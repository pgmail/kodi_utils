#!/usr/bin/env bash
set -euo pipefail

cleanup() {
    clear
    stty sane
}
trap cleanup EXIT INT TERM

if [[ $# -lt 1 || ! "$1" =~ ^[0-9]+$ || "$1" -eq 0 ]]; then
    echo "Usage: $0 <seconds>"
    exit 1
fi

SECONDS_TO_WAIT="$1"
total="$SECONDS_TO_WAIT"
secs="$total"

(
    while (( secs > 0 )); do
        echo $(( ( (total - secs) * 100 ) / total ))
        sleep 1
        ((secs--))
    done
    echo 100
) | dialog --gauge "Kodi will pause playback when the timer ends" 7 50

curl -s -u kodi:<password> \
     -H "Content-Type: application/json" \
     -d '{"jsonrpc":"2.0","method":"Player.PlayPause","params":{"playerid":1},"id":1}' \
     http://localhost:8080/jsonrpc \
     >/dev/null

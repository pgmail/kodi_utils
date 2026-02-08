#!/bin/bash


kill -9 `ps aux | grep kodi | grep -v grep | awk '{print $2}'`


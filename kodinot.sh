#!/bin/bash

#Kills all instances of kodi
kill -9 `ps aux | grep kodi | grep -v grep | awk '{print $2}'`


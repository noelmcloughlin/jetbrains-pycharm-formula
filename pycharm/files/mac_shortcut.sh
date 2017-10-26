#!/usr/bin/env bash

case $1 in
[Cc]) app='PyCharm CE.app'
      ;;
[Pp]) app='PyCharm PE.app'
      ;;
*)    echo 'Missing argument'
      exit 1
      ;;
esac
Source="/Applications/$app"
Destination="{{ homes }}/{{ user }}/Desktop"
/usr/bin/osascript -e "tell application \"Finder\" to make alias file to POSIX file \"$Source\" at POSIX file \"$Destination\""


#!/bin/bash

if pgrep -x wayvibes >/dev/null; then
  killall wayvibes
else
  wayvibes ~/Apps/wayvibes/soundpacks/akko_lavender_purples/ -bg -v 10
fi

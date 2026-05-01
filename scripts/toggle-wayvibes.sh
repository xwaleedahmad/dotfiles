#!/bin/bash

if pgrep -x wayvibes >/dev/null; then
  killall wayvibes
else
  wayvibes /opt/wayvibes/soundpacks/akko_lavender_purples/ -bg -v 5
fi

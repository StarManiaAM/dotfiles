#!/bin/sh

# Check if Bluetooth is powered on
if ! bluetoothctl show | grep -q "Powered: yes"; then
  # Powered off: Grayed out
  echo "%{F#66ffffff}"
else
  # Check if any device is actually connected
  if echo info | bluetoothctl | grep -q "Connected: yes"; then
    # Powered on AND Connected: Blue
    echo "%{F#2193ff}"
  else
    # Powered on but Disconnected: Default color
    echo ""
  fi
fi

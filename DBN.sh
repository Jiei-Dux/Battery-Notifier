s#! /bin/bash

# || WARNING: THE CODE BELOW KILLS DUPLICATE INSTANCES || #

for pid in $(pgrep -f DBN.sh);
do
  if [ $pid != $$ ]; then
    kill $pid
  fi
done

# || WARNING: THE CODE ABOVE KILLS DUPLICATE INSTANCES || #




# ~ YOU CAN EDIT THE CODE BELOW ~ #

# NOTE:
# you can check your device name using "upower -d"
# as well as use "*" if you're too lazy.
#
# Configuration:
DEVICE_NAME='battery_BAT1'

FULL_BATTERY_THRESHOLD=85
LOW_BATTERY_THRESHOLD=20
CRIT_BATTERY_THRESHOLD=10

# ~ YOU CAN EDIT THE CODE ABOVE ~ #




# || WARNING: DO NOT EDIT THE CODE BELOW || #

while true
do

  LOCATION='/org/freedesktop/UPower/devices'
  DEVICE_LOCATION="$LOCATION/$DEVICE_NAME"
  CMD=$(upower -i "$DEVICE_LOCATION")

  BATTERY_PERCENTAGE=$(awk '{gsub("%","")} /percentage/ {printf "%s\n", $NF}' <<< "$CMD")
  STATE=$(awk '/state/ {print $NF}' <<< "$CMD" | grep -c "discharging")



  NOTIF=$(notify-send --app-name "Dux's Battery Notfier" -t 2000 -u normal)



  if [[ "$STATE" -eq 1 && "$BATTERY_PERCENTAGE" -le "$CRIT_BATTERY_THRESHOLD" ]]; then
    systemctl suspend
  fi

  if [[ "$STATE" -eq 1 && "$BATTERY_PERCENTAGE" -le "$LOW_BATTERY_THRESHOLD" ]]; then
    notify-send --app-name "Dux's Battery Notfier" -t 2000 -u normal "Battery Low. Plug the Charger!"
    play "/usr/share/sounds/Oxygen-Sys-App-Error-Serious.ogg"
  fi

  if [[ "$STATE" -eq 0 && "$BATTERY_PERCENTAGE" -ge "$FULL_BATTERY_THRESHOLD" ]]; then
    notify-send --app-name "Dux's Battery Notifier" -t 2000 -u normal "Battery Full. Unplug the Charger!"
    play "/usr/share/sounds/Niko-Niko-Nii-SFX.ogg"
  fi

  sleep 10
done

# || WARNING: DO NOT EDIT THE CODE ABOVE || #

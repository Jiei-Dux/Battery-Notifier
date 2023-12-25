#! /bin/bash

# || WARNING: THE CODE BELOW KILLS DUPLICATE INSTANCES || #

for pid in $(pgrep -f DBN.sh);
do
  if [ $pid != $$ ]; then
    kill $pid
  fi
done

# || WARNING: THE CODE ABOVE KILLS DUPLICATE INSTANCES || #




# ~ YOU CAN EDIT THE CODE BELOW ~ #

# THRESHOLDS:
LOW_BATTERY_THRESHOLD=20
CRIT_BATTERY_THRESHOLD=10
FULL_BATTERY_THRESHOLD=85

# ~ YOU CAN EDIT THE CODE ABOVE ~ #




# || WARNING: DO NOT EDIT THE CODE BELOW || #

while true
do

  # * Variables Below * #

  BATTERY_PERCENTAGE=$(cat /sys/class/power_supply/*/capacity)
  STATE=$(cat /sys/class/power_supply/BAT1/status)

  NOTIF() { notify-send --app-name "Dux's Battery Notifier" -t 2000 -u normal "$1" }

  # * Variables Above * #




  if [[ $STATE -eq 1 && $BATTERY_PERCENTAGE -le $CRIT_BATTERY_THRESHOLD ]]; then
    systemctl suspend
  fi

  if [[ $STATE -eq 1 && $BATTERY_PERCENTAGE -le $LOW_BATTERY_THRESHOLD ]]; then
    NOTIF "Battery Low. Plug the Charger!"
    play "/usr/share/sounds/Oxygen-Sys-App-Error-Serious.ogg"
  fi

  if [[ $STATE -eq 0 && $BATTERY_PERCENTAGE -ge $FULL_BATTERY_THRESHOLD ]]; then
    NOTIF "Battery Full. Unplug the Charger!"
    play "/usr/share/sounds/Niko-Niko-Nii-SFX.ogg"
  fi

  sleep 10
done

# || WARNING: DO NOT EDIT THE CODE ABOVE || #

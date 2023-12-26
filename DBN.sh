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




# * Variables Below * #

BATTERY_PATH="/sys/class/power_supply/*/capacity"
STATUS_PATH="/sys/class/power_supply/*/status"

PERCENTAGE=$(cat $BATTERY_PATH)
STATE=$(cat $STATUS_PATH)

sendNotification() {
  notify-send --app-name "Dux's Battery Notifier" -t 2000 -u normal "$1"
}

# * Variables Above * #




# || WARNING: THE CODES BELOW HANDLES ERRORS || #

if ! command -v play &> /dev/null; then
  sendNotification "Error: 'play' command cannot be found... :3"
  exit 1
fi

if ! command -v systemctl &> /dev/null; then
  sendNotification "Error: 'systemctl' command cannot be found... :3"
  exit 1
fi




if [ ! -r $BATTERY_PATH ]; then
  sendNotification "Error: Cannot read battery capacity file... :3"
  exit 1
fi

if [ ! -r $STATUS_PATH ]; then
  sendNotification "Error: Cannot read battery status file... :3"
  exit 1
fi

# || WARNING: THE CODES ABOVE HANDLES ERRORS || #




# || WARNING: DO NOT EDIT THE CODE BELOW || #

while true
do

  if [[ $STATE -eq 1 && $PERCENTAGE -le $CRIT_BATTERY_THRESHOLD ]]; then
    systemctl suspend
  fi

  if [[ $STATE -eq 1 && $PERCENTAGE -le $LOW_BATTERY_THRESHOLD ]]; then
    sendNotification "Battery Low. Plug the Charger!"
    play "/usr/share/sounds/Oxygen-Sys-App-Error-Serious.ogg"
  fi

  if [[ $STATE -eq 0 && $PERCENTAGE -ge $FULL_BATTERY_THRESHOLD ]]; then
    sendNotification "Battery Full. Unplug the Charger!"
    play "/usr/share/sounds/Niko-Niko-Nii-SFX.ogg"
  fi

  sleep 10
done

# || WARNING: DO NOT EDIT THE CODE ABOVE || #

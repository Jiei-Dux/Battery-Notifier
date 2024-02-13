#! /bin/bash

# || WARNING: THE CODE BELOW KILLS DUPLICATE INSTANCES || #

for pid in $(pgrep -f DBN.sh);
do
  if [ $pid != $$ ]; then
    kill $pid
  fi
done

# || WARNING: THE CODE ABOVE KILLS DUPLICATE INSTANCES || #








# || WARNING: THE CODES BELOW HANDLES ERRORS || #
#:<<COMMENT

if ! command -v play &> /dev/null; then
  sendNotification "Error: 'play' command cannot be found... :3"
  exit 1
fi

if ! command -v systemctl &> /dev/null; then
  sendNotification "Error: 'systemctl' command cannot be found... :3"
  exit 1
fi

if ! command -v upower &> /dev/null; then
  sendNotification "Error: 'upower' command cannot be found... :3"
  exit 1
fi

# || WARNING: DO NOT EDIT THE CODE ABOVE || #








# || WARNING: DO NOT EDIT THE CODE BELOW || #

# ~ VARIABLES ~ #

:<<COMMENT

LOG_FILE="/home/*/.log/battery-notifier/battery_notifier_log.txt"

logMessage() {
  echo "$(date '+%Y-%m-%d %I:%M:%S') $1" >> $LOG_FILE
}

# logMessage "YEET"
# cat $LOG_FILE

COMMENT




SOUND_FILE_LOCATION="/home/*/.sounds"

# play $SOUND_FILE_LOCATION/Oxygen-Sys-App-Error-Serious.ogg
# play $SOUND_FILE_LOCATION/Niko-Niko-Nii-SFX.ogg

sendNotification() {
  notify-send --app-name "DBN - Dux's Battery Notifier" -t 4000 -u normal "$1"
}

debugNotification() {
  notify-send --app-name "Debug Notif" -t 4000 -u normal "$1"
}

# sendNotification "YEET"
# debugNotification "YEET"

# ~ VARIABLES ~ #

# || WARNING: DO NOT EDIT THE CODE ABOVE || #








# THRESHOLDS #

critical_battery_threshold=15
low_battery_threshold=25
full_battery_threshold=85

# THRESHOLDS #








# :<<COMMENT
while true
do

  DEVICE_NAME=$(upower -e | grep 'battery' | sed 's/.*\/\(.*\)$/\1/')

  LOCATION='/org/freedesktop/UPower/devices'
  BAT_LOCATION="$LOCATION/$DEVICE_NAME"

  CMD=$(upower -i "$BAT_LOCATION")

  PCT=$(awk '{gsub("%","")} /percentage/ {printf "%s\n", $NF}' <<< "$CMD")
  STATE=$(awk '/state/ {print $NF}' <<< "$CMD" | grep -c "discharging")

  # echo $DEVICE_NAME
  # echo $BAT_LOCATION
  # echo $CMD
  # echo $PCT
  # echo $STATE




  if [[ "$STATE" -eq 1 && "$PCT" -le $critical_battery_threshold ]]; then
    systemctl suspend
  fi

  if [[ "$STATE" -eq 1 && "$PCT" -le $low_battery_threshold ]]; then
    sendNotification "Battery Low. Plug the Charger!"
    play "$SOUND_FILE_LOCATION/Oxygen-Sys-App-Error-Serious.ogg"
  fi

  if [[ "$STATE" -eq 0 && "$PCT" -ge $full_battery_threshold ]]; then
    sendNotification "Battery Full. Unplug the Charger!"
    play "$SOUND_FILE_LOCATION/Niko-Niko-Nii-SFX.ogg"
  fi

  sleep 10
done
# COMMENT
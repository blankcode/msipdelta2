#!/bin/bash

LOG_DATE="$(date +"%Y%m%d")";

main() {
  # Varriables
  ## How many days to hold on to logs for.
  LOG_RETENSION=30
  ## Names of logs without date or extension.
  LOGS="msipdelta pull log_clean"

  # Cleaning Function
  clean_log () {
    find ~/msipdelta2/var/log/ -mtime +$LOG_RETENSION -name "$LOG_NAME*"
  }

  # Main Loop
  for LOG_NAME in $LOGS; do 
      clean_log $LOG_NAME
    done;
};

main >> ./var/log/log_clean.$LOG_DATE.log
#!/bin/bash

LOG_DATE="$(date +"%Y%m%d")";

main() {
  echo "Starting... $(date)"
  cd /root/msipdelta2 && echo "cded, am in $(pwd)" || echo "Bad Dir."

  echo "Pulling."
  git pull && echo "Pulled" || echo "Bad Pull."

  echo "Ending... $(date)"
  exit 0;
};

main >> ./var/log/package_update.$LOG_DATE.log
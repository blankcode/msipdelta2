#!/bin/bash

LOG_DATE="$(date +"%Y%m%d")";
# Log dir? If non then create it/
(ls ~/msipdelta2/var/log > /dev/null) || mkdir -P ~/msipdelta2/var/log;

main() {
  echo "Starting... $(date)"
  cd /root/msipdelta2 && echo "cded, am in $(pwd)" || echo "Bad Dir."

  echo "Pulling."
  git pull && echo "Pulled" || echo "Bad Pull."

  echo "Ending... $(date)"
  exit 0;
};

main >> ./var/log/package_update.$LOG_DATE.log
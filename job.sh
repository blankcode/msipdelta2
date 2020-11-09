#!/bin/bash
# Call ipdelta.sh on each service in the "service" file

LOG_DATE="$(date +"%Y%m%d")";
# Log dir? If non then create it/
(ls ~/msipdelta2/var/log > /dev/null) || mkdir -P ~/msipdelta2/var/log;

main() {
  cd /root/msipdelta2;

  # Is there internet?
  wget -q --spider http://google.com
  [[ $? == 0 ]] || { echo "No Connection!"; exit 1; };

  # When 
  DATE="$(date +"%Y%m%d-%H%M%S%z")";

  START=$(date -d "$1" +%s) # Place at the beginning of the script.

  lastRun() { echo -ne "$DATE" > /root/msipdelta2/LAST_RUN; };

  # GIT Stuff
  git_add_commit_push() {
    # GIT add new files and commit
    git add --all;
    git commit -m "Automated Update: $DATE";
    # Push changes
    git push origin master;
  };

  cat ./services | while read -r service;
    do ./ipdelta.sh $service; echo '############';
    done;

  # Run time
    # Place near the end of your script.
    NOW=$(date +%s)
    SEC=$(($NOW - $START))
    echo "$(date +"%Y%m%d-%H%M%S%z"): Run time was $SEC Seconds"

  lastRun

  # Do GIT Stuff
  git_add_commit_push;
};

main >> ~/msipdelta2/var/log/msipdelta2.$LOG_DATE.log
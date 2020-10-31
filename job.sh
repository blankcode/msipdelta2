#!/bin/bash
# Call ipdelta.sh on each service in the "service" file

cd /root/msipdelta2;

wget -q --spider http://google.com
[[ $? == 0 ]] || { echo "No Connection!"; exit 1; };

# When 
DATE="$(date +"%Y%m%d-%H%M%S%z")";

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

# Do GIT Stuff
git_add_commit_push;
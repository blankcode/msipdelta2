# Call ipdelta.sh on each service in the "service" file

cat ./services | while read -r service;
  do ./ipdelta.sh $service;
  done;
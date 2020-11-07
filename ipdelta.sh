#!/bin/bash

# Mail Services IP Delta 2.0
  # By Brian Blankenship
  # While they did not work on this directly (well yet) I want to thank:
  # William Hofferbert, Dan Jackson, Eva Perman, Josh Kaplan and, Shaun Biggs.
  # I've learned a lot for you guys. Thank you all so much.
  # Pre-Reqs: BASH, Git, MD5Sum, Internet Access

# ./ipdelta.sh "JIRA" "_spf.atlassian.net mail-us.atlassian.net mail-eu.atlassian.net"
# ./ipdelta.sh "Google" "_spf.google.com"

cd /root/msipdelta2;

# Wheres, whats and who
SERVICE_NAME="$1";
MAIN_REC=$2;

# directories
DOMAIN_DIR="./$SERVICE_NAME";
TMP_FOLDER="$DOMAIN_DIR/tmp";
OUTPUT_FOLDER="$DOMAIN_DIR/list";
SRC_ARCH="$DOMAIN_DIR/source_archive";

# files
V4TMP="$TMP_FOLDER/IPv4_tmp";
V6TMP="$TMP_FOLDER/IPv6_tmp";
V4FILE="$OUTPUT_FOLDER/IPv4";
V6FILE="$OUTPUT_FOLDER/IPv6";
V4SRC="$SRC_ARCH/IPv4_$DATE";
V6SRC="$SRC_ARCH/IPv6_$DATE";

make_rdy() {
  # Prep spaces.
  [[ -d $DOMAIN_DIR ]] || mkdir -pv "$DOMAIN_DIR";
  [[ -d $TMP_FOLDER ]] || mkdir -pv "$TMP_FOLDER";
  [[ -d $OUTPUT_FOLDER ]] ||  mkdir -pv "$OUTPUT_FOLDER";
  [[ -d $SRC_ARC ]] || mkdir -pv "$SRC_ARCH";
  [[ -f $V4TMP ]] && >> "$V4TMP";
  [[ -f $V6TMP ]] && >> "$V6TMP";
};

current_list() {
  cp -v $V4TMP $V4FILE;
  cp -v $V6TMP $V6FILE;
};

source_archive() {
  cp -v $V4TMP $V4SRC;
  cp -v $V6TMP $V6SRC;
};

v4changes() {
  md5tmp=$(md5sum $V4TMP|cut -d" " -f1);
  md5file=$(md5sum $V4FILE|cut -d" " -f1);

  [[ "$md5tmp" != "$md5file" ]] &&  { current_list; source_archive; } || echo " - No IPv4 Changes for $SERVICE_NAME";
  unset md5tmp;
  unset md5file;
};

v6changes() {
  md5tmp=$(md5sum $V6TMP|cut -d" " -f1);
  md5file=$(md5sum $V6FILE|cut -d" " -f1);

  [[ "$md5tmp" != "$md5file" ]] && { current_list; source_archive; } || echo " - No IPv6 Changes for $SERVICE_NAME";
  unset md5tmp;
  unset md5file;
};

clean_up() {
  # Um... Well, it cleans up.
  rm -rfv "$TMP_FOLDER";
};

## Rewrote the GIT func by hand...
git_add_commit_push() {
  # GIT add new files and commit
  git add --all;
  git commit -m "Automated Update: $DATE";
  # Push changes
  git push origin master;
};

## dig the mail SPF record for MAIN_REC and save it to a file
resolve_this() {
  # resolve the presented domain
  #return=$(dig +short TXT $1)
  return=$(dig +short TXT $1 | grep "v=spf1" | perl -pe 's/"v=spf1 //g' | perl -pe 's/ .all"//g');
  # clear $results just in case
  results="";
  # testing phase "What is this result?"
  for result in $return; do
    # its an include resolve it
    [[ $result == *"include:"* ]] && { resolve_this $(echo $result | cut -d: -f2); } || {
      # its an redirect resolve it
      [[ $result == *"redirect:"* ]] && { resolve_this $(echo $result | cut -d: -f2); } || {
        # it a IPv4 send it to the IPv4 tmp file
        [[ $result == "ip4:"* ]] && { echo $result | sed 's/ip4://g' >> $V4TMP; } || {
          # it a IPv6 send it to the IPv6 tmp file
          [[ $result == "ip6:"* ]] && { echo $result | sed 's/ip6://g' >> $V6TMP; };
        };
      };
    };
    done;
    sleep .5
};

"v=spf1 ip4:40.92.0.0/15 ip4:40.107.0.0/16 ip4:52.100.0.0/14 ip4:104.47.0.0/17 ip6:2a01:111:f400::/48 ip6:2a01:111:f403::/48 include:spfd.protection.outlook.com -all"


## main
# git pull; # Updates from somewhere else?
# Get ready.
clean_up;
make_rdy;
# Start the whole
for REC in $MAIN_REC;
  do resolve_this $REC;
  done
# IPv4 Changes
v4changes;
# IPv4 Changes
v6changes;
# Cleanup the tmp files
clean_up;
# Do GIT Stuff
#git_add_commit_push;
#!/bin/bash

# Mail Services IP Delta
  # By Brian Blankenship
  # While they did not work on this directly (well yet) I want to thank:
  # William Hofferbert, Dan Jackson, Eva Perman and, Shaun Biggs.
  # I've learned a lot for you guys. Thank you all so much.
  # Pre-Reqs: BASH, Git, MD5Sum, Internet Access

# Wheres, whats and who
MAIN_REC="$1"
MAIN_DOMAIN=$(echo "$MAIN_REC" | rev | cut -d\. -f1,2 | rev)

# When 
DATE="$(date +"%Y%m%d-%H%M%S%z")"

# directories
#INSTALL_DIR="./"
DOMAIN_DIR="./$MAIN_DOMAIN"
TMP_FOLDER="$DOMAIN_DIR/tmp"
OUTPUT_FOLDER="$DOMAIN_DIR/list"
SRC_ARCH="$DOMAIN_DIR/source_archive"

# files
V4TMP="$TMP_FOLDER/IPv4_tmp"
V6TMP="$TMP_FOLDER/IPv6_tmp"
V4FILE="$OUTPUT_FOLDER/IPv4"
V6FILE="$OUTPUT_FOLDER/IPv6"
V4SRC="$SRC_ARCH/IPv4_$DATE"
V6SRC="$SRC_ARCH/IPv6_$DATE"

make_rdy() {
  # Prep spaces.
  [[ -d $DOMAIN_DIR ]] || mkdir -pv "$DOMAIN_DIR"
  [[ -d $TMP_FOLDER ]] || mkdir -pv "$TMP_FOLDER"
  [[ -d $OUTPUT_FOLDER ]] ||  mkdir -pv "$OUTPUT_FOLDER"
  [[ -d $SRC_ARC ]] || mkdir -pv "$SRC_ARCH"
  [[ -f $V4TMP ]] && >> $V4TMP
  [[ -f $V6TMP ]] && >> $V6TMP
};

current_list() {
  cp -v $V4TMP $V4FILE
  cp -v $V6TMP $V6FILE
};

source_archive() {
  cp -v $V4TMP $V4SRC
  cp -v $V6TMP $V6SRC
};

sort() {
  sort -i "$V4TMP"
  sort -i "$V6TMP"
}

v4changes() {
  md5tmp=$(md5sum $V4TMP|cut -d" " -f1)
  md5file=$(md5sum $V4FILE|cut -d" " -f1)

  [[ "$md5tmp" != "$md5file" ]] && {
    current_list; source_archive;
  };
};

v6changes() {
  md5tmp=$(md5sum $V6TMP|cut -d" " -f1)
  md5file=$(md5sum $V6FILE|cut -d" " -f1)

  [[ "$md5tmp" != "$md5file" ]] && {
    current_list; source_archive;
  };
};

clean_up() {
  # Um... Well, it cleans up.
  rm -rfv "$TMP_FOLDER"
};

git() {
  # GIT add new files and commit
  git add --all;
  git commit -m "Automated Updated: $(date "+%Y%m%d-%H:%M:%S%z")";
  # GIT Push changes
  git push origin master;
};

## dig the mail SPF record for MAIN_REC and save it to a file
resolve_this() {
  # resolve the presented domain
  return=$(dig +short TXT $1)
  # trim the ""
  return=$(echo $return  | sed s/'"'//g)
  #echo "  *** " $1 " *** "; echo $return  | sed s/'"'//g
  # clear $results just in case
  results=""
  # testing phase "What is this result?"
  for result in $return; do
    # its an include resolve it
    [[ $result == *"include:"* ]] && resolve_this $(echo $result | cut -d: -f2) ||
      # its an redirect resolve it
      [[ $result == *"redirect:"* ]] && resolve_this $(echo $result | cut -d: -f2) ||
        # it a IPv4 send it to the IPv4 tmp file
        [[ $result == *"ip4:"* ]] && echo $result | sed 's/ip4://g' >> $V4TMP ||
          # it a IPv6 send it to the IPv6 tmp file
          [[ $result == *"ip6:"* ]] && echo $result | sed 's/ip6://g' >> $V6TMP
    done;
};

## main
# git pull; # Updates from somewhere else?
make_rdy; # Get ready.
resolve_this $MAIN_REC;  # Start the whole #!
v4changes; # IPv4 Changes
v6changes; # IPv4 Changes
clean_up; # Cleanup the tmp files
git # Publish changes to GitHub.com
# End

exit 0

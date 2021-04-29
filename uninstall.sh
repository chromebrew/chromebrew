#!/bin/bash -au

CREW_PREFIX=${CREW_PREFIX:-/usr/local}
PATH=/bin:/usr/bin

read -p $'\e[1;34mRemove Chromebrew and all installed packages? [y/N]: \e[0m' respond
case ${respond} in
  y|Y|"")
     echo -ne "\e[1mProceeding (This may take a while)...\e[0m"
     ;;
  *)
     echo -e "\e[1;31mNo changes made.\e[0m"
     exit 1
     ;;
esac

rm -rf ${CREW_PREFIX}

${CREW_PREFIX}/bin/sed -e '/source.*profile/d' \
        -e '/# DO NOT DELETE THIS LINE/d' \
        -e '/# See .*profile for further details/d' -i ~/.bashrc

echo -e "\n\n\e[1;32mChromebrew removed successfully.\e[0m"

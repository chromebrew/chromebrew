#!/bin/bash -au

CREW_PREFIX=${CREW_PREFIX:-/usr/local}
PATH=/bin:/usr/bin

# spin animation
function spin() {
  local spin='/ - \\ |'
  echo
  while true; do
      for sp in ${spin}; do
        echo -ne "\r\e[1mProceeding (This may take a while)... ${sp} \e[0m"
        sleep 0.1
     done
   done
}

read -p $'\e[1;34mRemove Chromebrew and all installed packages? [y/N]: \e[0m' respond
case ${respond} in
  y|Y|"")
     spin &
     disown %1
     ;;
  *)
     echo -e "\e[1;31mNo changes made.\e[0m"
     exit 1
     ;;
esac

rm -rf ${CREW_PREFIX}/lib/crew/
rm -rf ${CREW_PREFIX}/tmp/crew/
rm -f ${CREW_PREFIX}/etc/env.d/05-chromebrew

${CREW_PREFIX}/bin/sed -e '/source.*profile/d' \
        -e '/# DO NOT DELETE THIS LINE/d' \
        -e '/# See .*profile for further details/d' -i ~/.bashrc

for file in $(cat ${CREW_PREFIX}/etc/crew/meta/*.filelist); do
  rm -f ${file} 2> /dev/null
done

for dir in $(cat ${CREW_PREFIX}/etc/crew/meta/*.directorylist); do
  rmdir -p ${dir} 2> /dev/null
done

rm -rf ${CREW_PREFIX}/etc/crew/

# stop animation
kill $!

echo -e "\n\n\e[1;32mChromebrew removed successfully.\e[0m"
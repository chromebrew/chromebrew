#!/bin/bash
GREEN='\e[1;32m';
RED='\e[1;31m';
BLUE='\e[1;34m';
YELLOW='\e[1;33m';
RESET='\e[0m'
CREW_PREFIX="${CREW_PREFIX:-/usr/local}"
CREW_LIB_PREFIX=${CREW_PREFIX}/lib
EXTENSION_PREFIX=${HOME}/MyFiles/.extension
PWA_PREFIX=${CREW_LIB_PREFIX}/pwa
SERVER=${PWA_PREFIX}/server.rb
SENDER=${PWA_PREFIX}/send.rb
APPICON_PATH=${EXTENSION_PREFIX}/icon
ID=id_id
HELP='
  -s                  Start shortcut server
  -n (App Name)       Make a new shortcut
  -h                  Show this message
  -u (URL)            Open URL
  -t                  Open Chrome terminal
'
case ${1} in
  -s)
       pkill ruby
       exec ruby ${SERVER} &
       ;;
  -n)
       pkill ruby
       #######################################
       # icon
       CMD=${2}
       DESKTOP_FILE=$( find ${CREW_PREFIX} -name ${2}.desktop | sed -n '1p' )
       if [[ ${DESKTOP_FILE} != '' ]]; then
         APPNAME=$(grep 'Name=' ${DESKTOP_FILE} | cut -d'=' -f2 | sed -n '1p' )
       else
         APPNAME=${2^}
       fi
       if [ -f "${APPICON_PATH}/${APPNAME}.png" ]; then
         echo -e "${GREEN}Found an icon for ${APPNAME^}, using it.${RESET}"
       else
         icon () { ls -1 ${CREW_PREFIX}/share/pixmaps/ | grep ${CMD}; }
         if [[ $(icon) != '' ]]; then
           NUM=$(icon | wc -l)
           if [[ $NUM = 1 ]]; then
             echo -e "${GREEN}Found an preinstalled icon for ${APPNAME^}, using it.${RESET}"
             convert ${CREW_PREFIX}/share/pixmaps/$(icon) ${APPICON_PATH}/${2}.png
           else
             echo -e "${BLUE}${NUM} icons were found for ${APPNAME^}, here is the path of them${RESET}"
             icon
             read -r -p "Which icon do you want to use (Enter the path): " icon_path
             echo -e "${RESET}"
           fi
         else
           echo -e "${YELLOW}${2^} does not provide any icon :/ Using default Chromebrew icon.${RESET}"
         fi
       fi
       if [[ ${ICON_PATH} = '' ]]; then
           icon_path="${APPICON_PATH}/${2}.png"
       fi
       convert ${ICON_PATH} -resize 1024x1024 ${APPICON_PATH}/${2}.png
       echo -e "${GREEN}Shortcut for ${2^} deployed!${RESET}"
       pkill ruby
       ruby ${PWA_PREFIX}/sender.rb "chrome-extension://${ID}/main.html?cmd=${2}&friendly_name=${APPNAME}"
       sleep 5
       exec ruby ${SERVER} &
       ;;
  -h)
       echo -e "${BLUE}${help}${RESET}"
       ;;
  -u)  
       pkill ruby
       ruby ${SENDER} "$2"
       exec ruby ${SERVER} &
       ;;
  -t)  
       pkill ruby
       ruby ${SENDER} 'terminal'
       exec ruby ${SERVER} &
       ;;
  -i)
       pkill ruby
       ruby ${PWA_PREFIX}/sender.rb "chrome-extension://${ID}/main.html?cmd=terminal&friendly_name=Terminal"
       sleep 5
       exec ruby ${SERVER} &
       ;;
  *)
       echo -e "${BLUE}${HELP}${RESET}"
       ;;
esac

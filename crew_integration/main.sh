#!/bin/bash
GREEN='\e[1;32m';
RED='\e[1;31m';
BLUE='\e[1;34m';
YELLOW='\e[1;33m';
RESET='\e[0m'
CREW_PREFIX=/usr/local
CREW_LIB_PREFIX=${CREW_PREFIX}/lib
EXTENSION_PREFIX=~/MyFiles/.extension
PWA_PREFIX=${CREW_LIB_PREFIX}/pwa
SERVER=${PWA_PREFIX}/server.rb
SENDER=${PWA_PREFIX}/send.rb
app_path=${EXTENSION_PREFIX}/apps/${2}
extension_id=id_id
help='
  -s                  Start shortcut server
  -n (App Name)       Make a new shortcut
  -h                  Show this message
  -u (URL)            Open URL
  -t                  Open Chrome terminal
'
if [[ $extension_id = '' ]]; then echo -e "${BLUE}$(crew postinstall crew_integration)${RESET}" && exit 1; fi
case ${1} in
  -s)
       pkill ruby
       exec ruby ${SERVER} &
       ;;
  -n)
       pkill ruby
       mkdir -p ${app_path}
       cp ${PWA_PREFIX}/tools/* ${app_path}
       html=${app_path}/main.html
       js=${app_path}/starter.js
       
       sed -i "s/app/${2^}/g" ${html}
       
       sed -i "s/app/${2}/g" ${js}
       #######################################
       # icon
       appname=${2}
       if [ -f $PWA_PREFIX/icons/$appname.* ]; then
         echo -e "${GREEN}Found an icon for ${appname^}, using it.${RESET}"
         cp ${PWA_PREFIX}/icons/${appname}.png $app_path/icon.png
       else
         icon () { ls -1 $CREW_PREFIX/share/pixmaps/ | grep $appname; }
         if [[ $(icon) != '' ]]; then
           num=$(icon | wc -l)
           if [[ $num = 1 ]]; then
             echo -e "${GREEN}Found an preinstalled icon for ${appname^}, using it.${RESET}"
             convert ${CREW_PREFIX}/share/pixmaps/$(icon) ${app_path}/icon.png
           else
             echo -e "${BLUE}${num} icons were found for ${appname^}, here is the path of them${RESET}"
             icon
             read -r -p "Which icon do you want to use (Enter the path): " icon_path
             echo -e "${RESET}"
           fi
         else
           echo -e "${YELLOW}${2^} does not provide any icon :/ Using default Chromebrew icon.${RESET}"
           cp ${PWA_PREFIX}/icons/brew.png ${app_path}/icon.png
         fi
       fi
       convert ${app_path}/icon.png -resize 1024x1024 ${app_path}/icon.png
       echo -e "${GREEN}Shortcut for ${2^} deployed!${RESET}"
       pkill ruby
       ruby ${PWA_PREFIX}/sender.rb "chrome-extension://${extension_id}/apps/${2}/main.html"
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
       ruby ${PWA_PREFIX}/sender.rb "chrome-extension://${extension_id}/apps/hterm/main.html"
       exec ruby ${SERVER} &
       ;;
  *)
       echo -e "${BLUE}${help}${RESET}"
       ;;
esac

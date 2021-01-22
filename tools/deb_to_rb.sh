#!/bin/bash

set -e

if [[ ${1} != 'http*' ]]; then echo -e "#{RED}Missing deb downloading URL#{RESET}" && exit 1; fi

CREW_PREFIX=${CREW_PREFIX:-/usr/local}
CREW_LIB_PREFIX=${CREW_PREFIX}/lib
PKG_PREFIX=${CREW_LIB_PREFIX}/crew/packages
OUT=${2:-"${CREW_PREFIX}/${PKGNAME}.rb"}

GREEN='\e[1;32m';
RED='\e[1;31m';
BLUE='\e[1;34m';
YELLOW='\e[1;33m';
RESET='\e[0m'

rm -rf ${CREW_PREFIX}/tmp/deb && cd ${CREW_PREFIX}/tmp/

mkdir -p deb && cd ./deb

echo -e "${YELLOW}Downloading deb...${RESET}"
curl '-#' ${1} -o deb

ar x deb


tar xf control.tar.*
  
NAME=$(grep "Package: " ./control | sed -e 's/Package: //')
PKGNAME=$(echo ${name} | sed -e 's/-/_/g')
VER=$(grep "Version: " ./control | sed -e 's/Version: //' | sed -e 's/-/_/g')
INFO=$(grep "Description: " ./control | sed -e 's/Description: //' | sed -e 's/-/_/g')
SHA256SUM=$(sha256sum ./deb | cut -d ' ' -f1)

read -p "Package homepage (Press 'Enter' for default): " homepage
if [[ ${homepage} != '' ]]; then
  homepage=${homepage}
else
  unset homepage
fi

cat <<EOF> ${OUT}
require 'package'
class ${PKGNAME^} < Package
  description "${INFO}"
  ${homepage}
  compatibility "${deb_arch:-x86_64}"
  @_ver = "${VER}"
  version @_ver
  
  case ARCH
  when "${deb_arch:-x86_64}"
    source_url "${1}"
    source_sha256 "${SHA256SUM}"
EOF
DEPS=($( sed '/Pre-Depends: /d' ./control |\
         grep 'Depends: ' |\
         sed -e 's/Depends: //g' |\
         sed -e 's/-/_/g' |\
         sed -e 's/+/plus/g' |\
         sed -e 's/dpkg//g' |\
         sed -e 's/ ([^)]*)//g' |\
         sed -e 's/libx11/sommelier/g' |\
         sed -e 's/libgcc1/gcc10/g' |\
         sed -e 's/libpangocairo/pango, cairo/g' |\
         sed -e 's/libgtk_3/gtk3/g' |\
         sed -e 's/libglib/glib/g' |\
         sed -e 's/libgtk_2/gtk2/g' |\
         sed -e 's/libatspi...../at_spi2_core/g' |\
         sed -e 's/libqt5core5a/qtbase/g' |\
         sed -e 's/\.//g' |\
         sed -e 's/\,//g'))
         
  echo -e "${BLUE}Searching dependencies, this may take a while...${RESET}"
  for DEP in ${DEPS[*]}; do
    echo -e "${YELLOW}
  ${DEP}${RESET}"
  
  
    filter[1]=$(echo ${DEP} | sed -e 's/[0-9].*/ /g')
    filter[2]=$(echo ${filter[1]} | sed -e 's/lib//g')
    for i in ${!filter[*]}; do filter[$((${#filter[*]}+1))]=$(echo ${filter[${i}]} | sed -e 's/_ //g'); done
    for i in ${!filter[*]}; do filter[$((${#filter[*]}+1))]=$(echo ${DEP} | sed -e 's/_[0-9].*/ /g'); done
    for i in ${!filter[*]}; do filter[$((${#filter[*]}+1))]=$(echo ${filter[${i}]} | sed -e 's/lib//g'); done
    for i in ${!filter[*]}; do filter[$((${#filter[*]}+1))]=$(echo ${filter[${i}]} | sed -e 's/_//g'); done
    for i in ${!filter[*]}; do filter[$((${#filter[*]}+1))]=$(echo ${filter[${i}]} | sed -e 's/_.*//'); done
    for i in ${!filter[*]}; do filter[$((${#filter[*]}+1))]=${DEP}; done
    for i in ${!filter[*]}; do filter[$((${#filter[*]}+1))]=lib${filter[${i}]}; done
    for i in ${!filter[*]}; do filter[$((${#filter[*]}+1))]=$( echo ${filter[${i}]} | sed -e 's/[0-9]//g'); done
    for i in ${!filter[*]}; do filter[$((${#filter[*]}+1))]=$( echo ${filter[${i}]} | sed -e s/[0-9]$//g ); done
    for i in ${!filter[*]}; do filter[$((${#filter[*]}+1))]=$( echo ${filter[${i}]} | sed -e s/[2-9]//g ); done
  
    for filters in ${filter[*]}; do
      if [ -f ${PKG_PREFIX}/${filters}.rb ]; then 
        if [[ $(grep "depends_on '${filters}'" ${OUT}) = '' ]]; then
          echo -e "${GREEN}Package ${filters} found${RESET}"
          echo "    depends_on '${filters}' # ${DEP} dependency" >> ${OUT}
        elif [ -v VERBOSE ] || [[ $(grep "depends_on '${filters}' # ${DEP} dependency" ${OUT}) = '' ]] && [[ ${GETDEP} != 1 ]]; then
          echo -e "${GREEN}Dependency ${filters} already added!${RESET}"
          GETDEP=1
        fi
      elif [ -v VERBOSE ]; then
        echo -e "${RED}No such package: ${filters}${RESET}"
      fi
    done
    unset filter
    unset GETDEP
  done
  
cat <<EOF> ${OUT}
  end
    
  def self.build
    Dir.chdir '..' do
      system 'alien -tc *.deb'
      system 'tar xf *.tgz'
    end
  end
    
  def self.install
    Dir.chdir '..' do
      FileUtils.mkdir_p CREW_DEST_PREFIX
      ENV['CREW_NOT_STRIP'] = '1'
EOF

echo -e "${YELLOW}Unpacking 'data.tar' using 'tar', this may take a while...${RESET}"
tar xvf data.tar.* > /dev/null
if [ -d usr/bin ]; then echo '      FileUtils.mv "usr/bin/", CREW_DEST_PREFIX' >> ${OUT}; fi
if [ -d bin/ ]; then echo '      FileUtils.mv "bin/", CREW_DEST_PREFIX' >> ${OUT}; fi
if [ -d usr/local/bin/ ]; then echo '      FileUtils.mv "usr/local/bin/", CREW_DEST_PREFIX' >> ${OUT}; fi
if [ -d usr/sbin/ ]; then echo '      FileUtils.mv "usr/sbin/", CREW_DEST_PREFIX' >> ${OUT}; fi
if [ -d sbin/ ]; then echo '      FileUtils.mv "sbin/", CREW_DEST_PREFIX' >> ${OUT}; fi
if [ -d usr/local/sbin/ ]; then echo '      FileUtils.mv "usr/local/sbin/", CREW_DEST_PREFIX' >> ${OUT}; fi
if [ -d usr/share/ ]; then echo '      FileUtils.mv "usr/share/", CREW_DEST_PREFIX' >> ${OUT}; fi
if [ -d usr/local/share/ ]; then echo '      FileUtils.mv "usr/local/share/", CREW_DEST_PREFIX' >> ${OUT}; fi
if [ -d usr/opt/ ]; then echo '      FileUtils.mv "usr/opt/", CREW_DEST_PREFIX' >> ${OUT}; fi
if [ -d opt/ ]; then echo '      FileUtils.mv "opt/", CREW_DEST_PREFIX' >> ${OUT}; fi
if [ -d usr/local/opt/ ]; then echo '      FileUtils.mv "usr/local/opt/", CREW_DEST_PREFIX' >> ${OUT}; fi
if [ -d usr/lib/ ]; then echo '      FileUtils.mv "usr/lib/", CREW_DEST_PREFIX' >> ${OUT}; fi
if [ -d lib/ ]; then echo '      FileUtils.mv "lib/", CREW_DEST_PREFIX' >> ${OUT}; fi
if [ -d usr/local/lib/ ]; then echo '      FileUtils.mv "usr/local/lib/", CREW_DEST_PREFIX' >> ${OUT}; fi
if [ -d usr/lib64/ ]; then echo '      FileUtils.mv "usr/lib64/", CREW_DEST_PREFIX' >> ${OUT}; fi
if [ -d lib64/ ]; then echo '      FileUtils.mv "lib64/", CREW_DEST_PREFIX' >> ${OUT}; fi
if [ -d usr/local/lib64/ ]; then echo '      FileUtils.mv "usr/local/lib64/", CREW_DEST_PREFIX' >> ${OUT}; fi
echo '
    end
  end
end' >> ${OUT}

echo
echo -e "${GREEN}Package ${NAME^} generated${RESET}"

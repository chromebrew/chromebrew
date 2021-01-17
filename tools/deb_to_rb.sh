#!/bin/bash

set -e

CREW_PREFIX=/usr/local
CREW_LIB_PREFIX=${CREW_PREFIX}/lib
pkg_prefix=${CREW_LIB_PREFIX}/crew/packages
GREEN='\e[1;32m';
RED='\e[1;31m';
BLUE='\e[1;34m';
YELLOW='\e[1;33m';
RESET='\e[0m'

rm -rf ${out}

rm -rf ${CREW_PREFIX}/tmp/deb


cd ${CREW_PREFIX}/tmp/

mkdir -p deb && cd ./deb

echo -e "${YELLOW}Downloading deb...${RESET}"
curl '-#' ${1} -o deb

ar x deb


tar xf control.tar.*
  
name=$(grep "Package: " ./control | sed -e 's/Package: //')
pkgname=$(echo ${name} | sed -e 's/-/_/g')
ver=$(grep "Version: " ./control | sed -e 's/Version: //' | sed -e 's/-/_/g')
info=$(grep "Description: " ./control | sed -e 's/Description: //' | sed -e 's/-/_/g')
sha256sum=$(sha256sum ./deb | cut -d ' ' -f1)

out=${2}/${pkgname}.rb
  
cat <<EOF> ${out}
require 'package'
class ${pkgname^} < Package
  description '${info}'
  homepage ''
  compatibility 'all'
  @_ver = '${ver}'
  version @_ver
  
  case ARCH
  when 'x86_64'
    source_url '${1}'
    source_sha256 '${sha256sum}'
EOF
deps=($( sed '/Pre-Depends: /d' ./control |\
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
  for dep in ${deps[*]}; do
    echo -e "${YELLOW}
  ${dep}${RESET}"
  
  
    filter[1]=$(echo ${dep} | sed -e 's/[0-9].*/ /g')
    filter[2]=$(echo ${filter[1]} | sed -e 's/lib//g')
    for i in ${!filter[*]}; do filter[$((${#filter[*]}+1))]=$(echo ${filter[${i}]} | sed -e 's/_ //g'); done
    for i in ${!filter[*]}; do filter[$((${#filter[*]}+1))]=$(echo ${dep} | sed -e 's/_[0-9].*/ /g'); done
    for i in ${!filter[*]}; do filter[$((${#filter[*]}+1))]=$(echo ${filter[${i}]} | sed -e 's/lib//g'); done
    for i in ${!filter[*]}; do filter[$((${#filter[*]}+1))]=$(echo ${filter[${i}]} | sed -e 's/_//g'); done
    for i in ${!filter[*]}; do filter[$((${#filter[*]}+1))]=$(echo ${filter[${i}]} | sed -e 's/_.*//'); done
    for i in ${!filter[*]}; do filter[$((${#filter[*]}+1))]=${dep}; done
    for i in ${!filter[*]}; do filter[$((${#filter[*]}+1))]=lib${filter[${i}]}; done
    for i in ${!filter[*]}; do filter[$((${#filter[*]}+1))]=$( echo ${filter[${i}]} | sed -e 's/[0-9]//g'); done
    for i in ${!filter[*]}; do filter[$((${#filter[*]}+1))]=$( echo ${filter[${i}]} | sed -e s/[0-9]$//g ); done
    for i in ${!filter[*]}; do filter[$((${#filter[*]}+1))]=$( echo ${filter[${i}]} | sed -e s/[2-9]//g ); done
  
    for filters in ${filter[*]}; do
      if [ -f ${pkg_prefix}/${filters}.rb ]; then 
        if [[ $(grep "depends_on '${filters}'" ${out}) = '' ]]; then
          echo -e "${GREEN}Package ${filters} found${RESET}"
          echo "    depends_on '${filters}' # ${dep} dependency" >> ${out}
        elif [ -v verbose ] || [[ $(grep "depends_on '${filters}' # ${dep} dependency" ${out}) = '' ]] && [[ ${getdep} != 1 ]]; then
          echo -e "${GREEN}Dependency ${filters} already added!${RESET}"
          getdep=1
        fi
      elif [ -v verbose ]; then
        echo -e "${RED}No such package: ${filters}${RESET}"
      fi
    done
    unset filter
    unset getdep
  done
echo -e "
  end
    
  def self.build
    Dir.chdir '..' do
      system \"alien -tc *.deb\"
      system \"tar xf *.tgz\"
    end
  end
    
  def self.install
    Dir.chdir '..' do
      FileUtils.mkdir_p CREW_DEST_PREFIX
      ENV['CREW_NOT_STRIP'] = '1'" >> ${out}
echo -e "${YELLOW}Unpacking 'data.tar' using 'tar', this may take a while...${RESET}"
tar xvf data.tar.* > /dev/null
if [ -d usr/bin ]; then echo '      FileUtils.mv "usr/bin/", CREW_DEST_PREFIX' >> ${out}; fi
if [ -d bin/ ]; then echo '      FileUtils.mv "bin/", CREW_DEST_PREFIX' >> ${out}; fi
if [ -d usr/local/bin/ ]; then echo '      FileUtils.mv "usr/local/bin/", CREW_DEST_PREFIX' >> ${out}; fi
if [ -d usr/sbin/ ]; then echo '      FileUtils.mv "usr/sbin/", CREW_DEST_PREFIX' >> ${out}; fi
if [ -d sbin/ ]; then echo '      FileUtils.mv "sbin/", CREW_DEST_PREFIX' >> ${out}; fi
if [ -d usr/local/sbin/ ]; then echo '      FileUtils.mv "usr/local/sbin/", CREW_DEST_PREFIX' >> ${out}; fi
if [ -d usr/share/ ]; then echo '      FileUtils.mv "usr/share/", CREW_DEST_PREFIX' >> ${out}; fi
if [ -d usr/local/share/ ]; then echo '      FileUtils.mv "usr/local/share/", CREW_DEST_PREFIX' >> ${out}; fi
if [ -d usr/opt/ ]; then echo '      FileUtils.mv "usr/opt/", CREW_DEST_PREFIX' >> ${out}; fi
if [ -d opt/ ]; then echo '      FileUtils.mv "opt/", CREW_DEST_PREFIX' >> ${out}; fi
if [ -d usr/local/opt/ ]; then echo '      FileUtils.mv "usr/local/opt/", CREW_DEST_PREFIX' >> ${out}; fi
if [ -d usr/lib/ ]; then echo '      FileUtils.mv "usr/lib/", CREW_DEST_PREFIX' >> ${out}; fi
if [ -d lib/ ]; then echo '      FileUtils.mv "lib/", CREW_DEST_PREFIX' >> ${out}; fi
if [ -d usr/local/lib/ ]; then echo '      FileUtils.mv "usr/local/lib/", CREW_DEST_PREFIX' >> ${out}; fi
if [ -d usr/lib64/ ]; then echo '      FileUtils.mv "usr/lib64/", CREW_DEST_PREFIX' >> ${out}; fi
if [ -d lib64/ ]; then echo '      FileUtils.mv "lib64/", CREW_DEST_PREFIX' >> ${out}; fi
if [ -d usr/local/lib64/ ]; then echo '      FileUtils.mv "usr/local/lib64/", CREW_DEST_PREFIX' >> ${out}; fi
echo '    end
  end
end' >> ${out}

echo
echo -e "${GREEN}Package ${name^} generated${RESET}"

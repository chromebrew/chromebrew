require 'package'

class Gcc_tools < Package
  description 'Tools for working with gcc packages'
  homepage 'https://github.com/skycocker/chromebrew'
  version '1.2'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  def self.build
    system 'cat << "EOF" > crewfix
#!/bin/bash

# exit on fail
set -e

# define constants
CREW_PREFIX="${CREW_PREFIX:-/usr/local}"
ARCH="$(uname -m)"
LIB_SUFFIX=""
[ "${ARCH}" == "x86_64" ] && LIB_SUFFIX="64"

function download_check () {
  cd /tmp

  #download
  echo "Downloading ${1}..."
  curl --progress-bar -C - -L --ssl "${2}" -o "${3}"

  #verify
  echo "Verifying ${1}..."
  echo "${4}" "${3}" | sha256sum -c -
  case "${?}" in
  0) ;;
  *)
    echo "Verification failed, something may be wrong with the download."
    exit 1;;
  esac
}

if [ ! -f "${CREW_PREFIX}/lib${LIB_SUFFIX}/libssp.so.0" ]; then
  # prepare gcc11.1 derived libssp url and sha256
  case "${ARCH}" in
  "aarch64"|"armv7l")
    url="https://gitlab.com/api/v4/projects/26210301/packages/generic/libssp/11.1.0_armv7l/libssp-11.1.0-chromeos-armv7l.tar.xz"
    sha256="21d6872debb576b442a0a62ab7d0ae4bc765db83bf43cdb8e11c28f56e51d456"
    ;;
  "i686")
    url="https://gitlab.com/api/v4/projects/26210301/packages/generic/libssp/11.1.0_i686/libssp-11.1.0-chromeos-i686.tar.xz"
    sha256="5b02bf769ec3754f4b0c937e5420f13bf285bc81bdc9c68fbc6f63c56562682b"
    ;;
  "x86_64")
    url="https://gitlab.com/api/v4/projects/26210301/packages/generic/libssp/11.1.0_x86_64/libssp-11.1.0-chromeos-x86_64.tar.xz"
    sha256="356cd568080dd0e724081ec7f020d0b21e091d5552d175746f830c48830bd8b9"
    ;;
  esac
  tarfile="$(basename ${url})"
  name="${tarfile%%-*}"
  download_check "${name}" "${url}" "${tarfile}" "${sha256}"
  cd / && tar --wildcards -xvf /tmp/${tarfile} "${CREW_PREFIX#/}/lib${LIB_SUFFIX}/libssp.so*"
  rm -f /tmp/${tarfile}
fi

if [ ! -f "${CREW_PREFIX}/bin/ruby" ]; then
  # prepare ruby url and sha256
  case "${ARCH}" in
  "aarch64"|"armv7l")
    url="https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.0.1-1_armv7l/ruby-3.0.1-1-chromeos-armv7l.tar.xz"
    sha256="03f443d63cca0fb640ec4d11f3b1306a9719e775f8c706c732f9231e41e66afd"
    ;;
  "i686")
    url="https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.0.1-1_i686/ruby-3.0.1-1-chromeos-i686.tar.xz"
    sha256="dc388589df39c39e9c494e761ae2ca950a9b4f0573aa0d96508959787c050dcd"
    ;;
  "x86_64")
    url="https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.0.1-1_x86_64/ruby-3.0.1-1-chromeos-x86_64.tar.xz"
    sha256="4f86c98eaae1e708bf66f1c939a5cd07d5764b9b64ca827e6f7d5f61021bcb7e"
    ;;
  esac
  tarfile="$(basename ${url})"
  name="${tarfile%%-*}"
  download_check "${name}" "${url}" "${tarfile}" "${sha256}"
  cd / && tar -xvf /tmp/${tarfile}
  rm -f /tmp/${tarfile}
fi
EOF'

    system 'cat << "EOF" > gcc_switcher
#!/bin/bash
gccver=$(gcc -v 2>&1 | tail -1 | cut -d" " -f3)
v=$(echo $gccver | cut -d"." -f1)
if test $1; then
  valid=
  gv="7 8 10"
  for g in $gv; do
    [ $1 == $g ] && valid=1
  done
  [ ! $valid ] && echo "Usage: $(basename $0) [version] where [version] is one of $gv" && exit 1
  [ $1 == $v ] && echo "GCC version $gccver currently installed." && exit 1
  version=$1
else
  version=
  versions=(0 7 8 10)
  if [[ "$gccver" == "No" || "$gccver" == "gcc:" ]]; then
    until [[ " ${versions[@]} " =~ " ${version} " ]]; do
      echo "Enter the GCC version to install:"
      echo " 7 = GCC 7.4.0"
      echo " 8 = GCC 8.3.0"
      echo "11 = GCC 11.1.0"
      echo " 0 = Cancel"
      read version
    done
  else
    echo "GCC version $gccver currently installed."
    until [[ " ${versions[@]} " =~ " ${version} " ]]; do
      echo "Enter the GCC version to install:"
      case $v in
        7)
          echo " 8 = GCC 8.3.0"
          echo "11 = GCC 11.1.0"
          ;;
        8)
          echo " 7 = GCC 7.4.0"
          echo "11 = GCC 11.1.0"
          ;;
        10)
          echo " 7 = GCC 7.4.0"
          echo " 8 = GCC 8.3.0"
          ;;
        0)
          ;;
      esac
      echo " 0 = Cancel"
      read version
    done
  fi
fi
[ $v == $version ] && echo "GCC version $gccver currently installed." && exit 1
[ $version != 0 ] && crew remove curl gcc$v && crewfix && crew install curl gcc$version
EOF'
  end

  def self.install
    system "install -Dm755 crewfix #{CREW_DEST_PREFIX}/bin/crewfix"
    system "install -Dm755 gcc_switcher #{CREW_DEST_PREFIX}/bin/gcc_switcher"
  end

  def self.postinstall
    puts "This package contains two scripts:".lightblue
    puts
    puts "crewfix - Repairs the crew command if gcc is removed".lightblue
    puts "gcc_switcher - Allows switching between gcc versions".lightblue
    puts
    puts "In most cases, you will only need to use the gcc_switcher command.".lightblue
    puts "If the current gcc version is removed manually, however, and the".lightblue
    puts "crew command no longer works, you can repair with crewfix.".lightblue
    puts
  end
end

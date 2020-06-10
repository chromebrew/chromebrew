require 'package'

class Gcc_tools < Package
  description 'Tools for working with gcc packages'
  homepage 'https://github.com/skycocker/chromebrew'
  version '1.0'
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
  # prepare gcc8 url and sha256
  case "${ARCH}" in
  "aarch64"|"armv7l")
    url="https://dl.bintray.com/chromebrew/chromebrew/gcc8-8.3.0-chromeos-armv7l.tar.xz"
    sha256="fbd8a589befb3d10400af6e4975d02a6940bab4907628f8fc0d6913ea89f70ae"
    ;;
  "i686")
    url="https://dl.bintray.com/chromebrew/chromebrew/gcc8-8.3.0-chromeos-i686.tar.xz"
    sha256="4d625e92969fde16c1a92601740e22c07331f8056452edf7cf0bf2c1c88aa152"
    ;;
  "x86_64")
    url="https://dl.bintray.com/chromebrew/chromebrew/gcc8-8.3.0-chromeos-x86_64.tar.xz"
    sha256="ae8c8c33e4090f7fdbd39b2364754dcfc5f6bdd9a74062fde3eeb6272562f48b"
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
    url="https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.3-chromeos-armv7l.tar.xz"
    sha256="5e485a0320b298e1f5c4ff50d98c6fe6d06ad9a38d9119d580a8b469418e1e6a"
    ;;
  "i686")
    url="https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.3-chromeos-i686.tar.xz"
    sha256="6f4a5b96c31ef5ee4f09ac15da4c7a4a9d838ed5233038136ead1e155d17f342"
    ;;
  "x86_64")
    url="https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.3-chromeos-x86_64.tar.xz"
    sha256="352b78fc883cf8936136991fda9ca5d49e90b2951626158d6af8ef4b58d67f97"
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
if [[ "$gccver" == "No" || "$gccver" == "gcc:" ]]; then
  echo "Enter the GCC version to install:"
  echo "7 = GCC 7.4.0"
  echo "8 = GCC 8.3.0"
else
  echo "GCC version $gccver currently installed."
  echo "Enter the GCC version to install:"
  if [ "$gccver" == "8.3.0" ]; then
    echo "7 = GCC 7.4.0"
  fi
  if [ "$gccver" == "7.4.0" ]; then
    echo "8 = GCC 8.3.0"
  fi
fi
echo "0 = Cancel"
read version
case $version in
  7)
    crew remove gcc8 && crewfix && crew install gcc7
    ;;
  8)
    crew remove gcc7 && crewfix && crew install gcc8
    ;;
  *)
    ;;
esac
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

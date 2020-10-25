require 'package'

class Gcc_tools < Package
  description 'Tools for working with gcc packages'
  homepage 'https://github.com/skycocker/chromebrew'
  version '1.1'
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
    url="https://dl.bintray.com/chromebrew/chromebrew/ruby-2.7.2-chromeos-armv7l.tar.xz"
    sha256="a435e6bf7965e1a82e8842e5ea66bdd670ec9b627d785bd720d3d2652fc89f6d"
    ;;
  "i686")
    url="https://dl.bintray.com/chromebrew/chromebrew/ruby-2.7.2-chromeos-i686.tar.xz"
    sha256="81865864d3ba93b6cbd5dc8e1b6cb51bd2ebe854f6c01e282c1b73f379fb7caf"
    ;;
  "x86_64")
    url="https://dl.bintray.com/chromebrew/chromebrew/ruby-2.7.2-chromeos-x86_64.tar.xz"
    sha256="658808516b7a2e58f8102fd131e765aaa79f2a7c906d0330b7e883fbdc12d1a9"
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
      echo "10 = GCC 10.2.0"
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
          echo "10 = GCC 10.2.0"
          ;;
        8)
          echo " 7 = GCC 7.4.0"
          echo "10 = GCC 10.2.0"
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

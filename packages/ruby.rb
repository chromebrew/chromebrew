require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '2.6.3'
  source_url 'https://cache.ruby-lang.org/pub/ruby/2.6/ruby-2.6.3.tar.xz'
  source_sha256 '11a83f85c03d3f0fc9b8a9b6cad1b2674f26c5aaa43ba858d4b0fcc2b54171e1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.6.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.6.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.6.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.6.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3f16f7dcdd2422d3b7acf65696b5abda26fe6bff6ef4de6a5cd14174e0bea35f',
     armv7l: '3f16f7dcdd2422d3b7acf65696b5abda26fe6bff6ef4de6a5cd14174e0bea35f',
       i686: '13436a2f5341740c069bb07ebcc9f87c9e350b14c6bbc1a154ba95002c5a6839',
     x86_64: '74b3f4f34eb57b55fcde5bd665d2a4e27b3d9a7540de9578d7c91f15eb32c563',
  })

  depends_on 'gcc8'
  depends_on 'readline'
  depends_on 'ncurses'
  depends_on 'zlibpkg' => :build
  depends_on 'openssl' => :build
  # at run-time, system's gmp, openssl, readline and zlibpkg are possible to use

  def self.build
    system 'cat << "EOF" > ruby.sh
#!/bin/bash

# exit on fail
set -e

# define constants
CREW_PREFIX="${CREW_PREFIX:-/usr/local}"
ARCH="$(uname -m)"
LIB_SUFFIX=""
[ "${ARCH}" == "x86_64" ] && LIB_SUFFIX="64"

if [ -f "${CREW_PREFIX}/lib${LIB_SUFFIX}/libssp.so" ]; then
  ruby-bin "$@"
  exit 0
fi

# prepare gcc8 url and sha256
case "${ARCH}" in
"aarch64")
  url="https://dl.bintray.com/chromebrew/chromebrew/gcc8-8.3.0-chromeos-armv7l.tar.xz"
  sha256="fbd8a589befb3d10400af6e4975d02a6940bab4907628f8fc0d6913ea89f70ae"
  ;;
"armv7l")
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

tarfile="$(basename ${url})"
name="${tarfile%%-*}"
download_check "${name}" "${url}" "${tarfile}" "${sha256}"
cd / && tar --wildcards -xvf /tmp/${tarfile} "${CREW_PREFIX#/}/lib${LIB_SUFFIX}/libssp.so*"
rm -f /tmp/${tarfile}
ruby-bin "$@"
EOF'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-shared'
    system 'make'
    system 'cp ruby ruby-bin'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "install -Dm755 ruby.sh #{CREW_DEST_PREFIX}/bin/ruby"
    system "install -Dm755 ruby-bin #{CREW_DEST_PREFIX}/bin/ruby-bin"
  end

  def self.check
#    system "TMPDIR=#{CREW_PREFIX}/tmp make check"
  end
end

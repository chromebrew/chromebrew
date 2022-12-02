require 'package'

class Bind < Package
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/downloads/bind/'
  @_ver = '9.19.7'
  version @_ver
  license 'Apache-2.0, BSD, BSD-2, GPL-2, HPND, ISC and MPL-2.0'
  compatibility 'all'
  source_url 'https://gitlab.isc.org/isc-projects/bind9.git'
  git_hashtag "v#{@_ver.gsub('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.19.7_armv7l/bind-9.19.7-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.19.7_armv7l/bind-9.19.7-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.19.7_i686/bind-9.19.7-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.19.7_x86_64/bind-9.19.7-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a3e8f68ed11b1cb67814f028c79ea06b035fda8c74a539b9e3b01989e527bdbf',
     armv7l: 'a3e8f68ed11b1cb67814f028c79ea06b035fda8c74a539b9e3b01989e527bdbf',
       i686: '02127e0688511ed4e9eeb62c4cfe85d6599274b6b79fd9ea84532df798317a2a',
     x86_64: '8e662421a4455acd61ff113591c5adab45338fc151cfba652a2f9d2f0a3495f3'
  })

  depends_on 'jsonc'
  depends_on 'libcap'
  depends_on 'libuv'
  depends_on 'py3_ply'
  depends_on 'e2fsprogs' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'jemalloc' # R
  depends_on 'krb5' # R
  depends_on 'libedit' # R
  depends_on 'libidn2' # R
  depends_on 'libnghttp2' # R
  depends_on 'libunistring' # R
  depends_on 'libxml2' # R
  depends_on 'ncurses' # R
  depends_on 'openssl' # R
  depends_on 'zlibpkg' # R

  def self.build
    system 'autoreconf -fi'
    system 'filefix'
    system "CFLAGS='-DDIG_SIGCHASE' \
        ./configure \
        #{CREW_OPTIONS} \
         --enable-fixed-rrset \
         --enable-full-report \
         --with-openssl \
         --with-libidn2 \
         --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end

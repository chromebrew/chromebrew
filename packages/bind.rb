require 'package'

class Bind < Package
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/downloads/bind/'
  version '9.18.16'
  license 'Apache-2.0, BSD, BSD-2, GPL-2, HPND, ISC and MPL-2.0'
  compatibility 'all'
  source_url "https://ftp.isc.org/isc/bind9/#{version}/bind-#{version}.tar.xz"
  source_sha256 'c88234fe07ee75c3c8a9e59152fee64b714643de8e22cf98da3db4d0b57e0775'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.18.16_armv7l/bind-9.18.16-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.18.16_armv7l/bind-9.18.16-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.18.16_i686/bind-9.18.16-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.18.16_x86_64/bind-9.18.16-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7952f0a08296a953fcec93eae2414b5bb46ca8872282272e790a192ba4eac9c2',
     armv7l: '7952f0a08296a953fcec93eae2414b5bb46ca8872282272e790a192ba4eac9c2',
       i686: '67fbe2a286b9d51c2fe85288d43950ab488af45535fac3fc4ecb381d19ee786c',
     x86_64: 'e9026c5b1d05ae5b5cabfb8162cec563f6c55913121541fad9d3549f618454f1'
  })

  depends_on 'e2fsprogs' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'jemalloc' # R
  depends_on 'jsonc' # R
  depends_on 'krb5' # R
  depends_on 'libcap' # R
  depends_on 'libedit' # R
  depends_on 'libidn2' # R
  depends_on 'libnghttp2' # R
  depends_on 'liburcu' => :build
  depends_on 'libunistring' # R
  depends_on 'libuv' # R
  depends_on 'libxml2' # R
  depends_on 'ncurses' # R
  depends_on 'openssl' # R
  depends_on 'py3_ply' => :build
  depends_on 'zlibpkg' # R

  def self.build
    system 'filefix'
    system "CFLAGS='-DDIG_SIGCHASE' \
        ./configure \
        #{CREW_OPTIONS} \
         --enable-fixed-rrset \
         --enable-full-report \
         --with-openssl \
         --with-libidn2"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end

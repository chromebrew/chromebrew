require 'buildsystems/autotools'

class Bind < Autotools
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/downloads/bind/'
  version '9.18.21'
  license 'Apache-2.0, BSD, BSD-2, GPL-2, HPND, ISC and MPL-2.0'
  compatibility 'all'
  source_url "https://ftp.isc.org/isc/bind9/#{version}/bind-#{version}.tar.xz"
  source_sha256 'a556be22505d9ea4f9c6717aee9c549739c68498aff3ca69035787ecc648fec5'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.18.21_armv7l/bind-9.18.21-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.18.21_armv7l/bind-9.18.21-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.18.21_i686/bind-9.18.21-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.18.21_x86_64/bind-9.18.21-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b6041be3e1a2da68142d25e5322055e59776c22f3be3963bfec8f98b99ca516f',
     armv7l: 'b6041be3e1a2da68142d25e5322055e59776c22f3be3963bfec8f98b99ca516f',
       i686: '899bad21b6ebc0ff3928282943cde4c7c332da860cf5e652fc0ecefb532d80ae',
     x86_64: '2ace6554897a788547b015c55e2bdf7279c02e1cb3bbfb969c1c6f6aa6a63169'
  })

  depends_on 'e2fsprogs' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' => :build
  depends_on 'jemalloc' # R
  depends_on 'jsonc' # R
  depends_on 'krb5' # R
  depends_on 'libcap' # R
  depends_on 'libedit' # R
  depends_on 'libidn2' # R
  depends_on 'libnghttp2' # R
  depends_on 'libunistring' => :build
  depends_on 'liburcu' => :build
  depends_on 'libuv' # R
  depends_on 'libxml2' # R
  depends_on 'ncurses' => :build
  depends_on 'openssl' # R
  depends_on 'py3_ply' => :build
  depends_on 'zlibpkg' # R

  pre_configure_options "CFLAGS='#{CREW_ENV_OPTIONS_HASH['CFLAGS']} -DDIG_SIGCHASE'"
  configure_options '--enable-fixed-rrset \
         --enable-full-report \
         --with-openssl \
         --with-libidn2'
end

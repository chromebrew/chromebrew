require 'buildsystems/autotools'

class Bind < Autotools
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/bind/'
  version '9.20.0'
  license 'Apache-2.0, BSD, BSD-2, GPL-2, HPND, ISC and MPL-2.0'
  compatibility 'all'
  source_url "https://ftp.isc.org/isc/bind9/#{version}/bind-#{version}.tar.xz"
  source_sha256 'cc580998017b51f273964058e8cb3aa5482bc785243dea71e5556ec565a13347'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '271147a451d6a6c81231a7d1e2e74480f8e24e4cf26fc01dc9d4b40c918cf980',
     armv7l: '271147a451d6a6c81231a7d1e2e74480f8e24e4cf26fc01dc9d4b40c918cf980',
       i686: '8c4401d053912ccd13417d97edbaa8ba3a1c5c5bd6db0653f71d216f0d251f0b',
     x86_64: '0e0bf08ec93ad2ca55f2e0393882eec31f70185adf0a0c1a93a641d436d95425'
  })

  depends_on 'e2fsprogs' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' => :build
  depends_on 'jemalloc' # R
  depends_on 'json_c' # R
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

require 'buildsystems/autotools'

class Bind < Autotools
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/bind/'
  version '9.20.0-icu75.1'
  license 'Apache-2.0, BSD, BSD-2, GPL-2, HPND, ISC and MPL-2.0'
  compatibility 'all'
  source_url "https://ftp.isc.org/isc/bind9/#{version.split('-').first}/bind-#{version.split('-').first}.tar.xz"
  source_sha256 'cc580998017b51f273964058e8cb3aa5482bc785243dea71e5556ec565a13347'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c38d7b10a9da318f591bfc9daddfa427f4559bf836ab7c4d85a85b9dff5e64f8',
     armv7l: 'c38d7b10a9da318f591bfc9daddfa427f4559bf836ab7c4d85a85b9dff5e64f8',
       i686: 'bf43eb116dbce313bb2842af5b34221c1d1ffbcc9da14f7b103638666d3bde9b',
     x86_64: '15e82de63f95ca9ee4f48627e2240bac20e0991fb55b8e8006a5d5b8ac27d262'
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
  depends_on 'liburcu' # R
  depends_on 'libuv' # R
  depends_on 'libxml2' # R
  depends_on 'ncurses' => :build
  depends_on 'openssl' # R
  depends_on 'py3_ply' => :build
  depends_on 'zlib' # R

  pre_configure_options "CFLAGS='#{CREW_ENV_OPTIONS_HASH['CFLAGS']} -DDIG_SIGCHASE'"
  configure_options '--enable-fixed-rrset \
         --enable-full-report \
         --with-openssl \
         --with-libidn2'
end

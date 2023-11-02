require 'buildsystems/autotools'

class Bind < Autotools
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/downloads/bind/'
  version '9.18.19'
  license 'Apache-2.0, BSD, BSD-2, GPL-2, HPND, ISC and MPL-2.0'
  compatibility 'all'
  source_url "https://ftp.isc.org/isc/bind9/#{version}/bind-#{version}.tar.xz"
  source_sha256 '115e09c05439bebade1d272eda08fa88eb3b60129edef690588c87a4d27612cc'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.18.19_armv7l/bind-9.18.19-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.18.19_armv7l/bind-9.18.19-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.18.19_i686/bind-9.18.19-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.18.19_x86_64/bind-9.18.19-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8aa990e3de886a1e19d879ecec6a00f7253e1ee34d15b334d29cac0975e8fefc',
     armv7l: '8aa990e3de886a1e19d879ecec6a00f7253e1ee34d15b334d29cac0975e8fefc',
       i686: '0df1be2e43f32d38e74fe2ed8ba90aba038ba887733c9f9126655f031ab1c878',
     x86_64: 'ee5191b2caf150d23505db782800da2e94f87da3601b0d463cad06b63d4ae66f'
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

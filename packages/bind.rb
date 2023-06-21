require 'package'

class Bind < Package
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/downloads/bind/'
  version '9.18.16'
  license 'Apache-2.0, BSD, BSD-2, GPL-2, HPND, ISC and MPL-2.0'
  compatibility 'x86_64'
  source_url 'https://gitlab.isc.org/isc-projects/bind9.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.18.16_armv7l/bind-9.18.16-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.18.16_armv7l/bind-9.18.16-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.18.16_i686/bind-9.18.16-chromeos-i686.tar.zst',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.18.16_x86_64/bind-9.18.16-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e558664b7580684c06fbb746c531e5337ab760e6bc0891e5a8d23567b0410c9d',
     armv7l: 'e558664b7580684c06fbb746c531e5337ab760e6bc0891e5a8d23567b0410c9d',
       i686: 'c89e967767e8e94c759e659382e1d1d9e95abea58abdc91f7838e9c4db83cac6',
    x86_64: 'c05311d3614493bdeab6c4c09d4e26c72265e10368891fa591d5d0325b3ceecc'
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

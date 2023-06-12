require 'package'

class Bind < Package
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/downloads/bind/'
  version '9.19.9'
  license 'Apache-2.0, BSD, BSD-2, GPL-2, HPND, ISC and MPL-2.0'
  compatibility 'all'
  source_url 'https://gitlab.isc.org/isc-projects/bind9.git'
  git_hashtag "v#{version.gsub('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.19.9_armv7l/bind-9.19.9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.19.9_armv7l/bind-9.19.9-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.19.9_i686/bind-9.19.9-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bind/9.19.9_x86_64/bind-9.19.9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9cccc756b0f853e4ab80b2b20d809480c63407ae1342e79d3b40eb4c1a8d2fd2',
     armv7l: '9cccc756b0f853e4ab80b2b20d809480c63407ae1342e79d3b40eb4c1a8d2fd2',
       i686: '1cb7e48d387667fa5c7d51ebb391f50a5408142214b62eaa928592c5cb524e3b',
     x86_64: '02811689db43260e353d0c8d1ff9437d1401e59bf41d27a8fd49e52499fb4100'
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

require 'package'

class Bind < Package
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/downloads/bind/'
  @_ver = '9.17.12'
  version @_ver
  license 'Apache-2.0, BSD, BSD-2, GPL-2, HPND, ISC and MPL-2.0'
  compatibility 'all'
  source_url 'https://gitlab.isc.org/isc-projects/bind9.git'
  git_hashtag @_ver.gsub('.', '_')

  depends_on 'jsonc'
  depends_on 'libcap'
  depends_on 'libuv'
  depends_on 'py3_ply'

  def self.build
    system 'autoreconf -fiv'
    system 'filefix'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
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

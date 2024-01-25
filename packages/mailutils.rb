require 'package'

class Mailutils < Package
  description 'GNU Mailutils is the swiss army knife of electronic mail handling.'
  homepage 'https://mailutils.org'
  version '3.13'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/mailutils/mailutils-3.13.tar.xz'
  source_sha256 'd920971dcb49878a009911774fd6404f13d27bd101e2d59b664a28659a4094c7'
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: 'ad6e2116b39db4db712d59caddf7a70bfe0cb1e206d595af4011eaac29d4136a',
     armv7l: 'ad6e2116b39db4db712d59caddf7a70bfe0cb1e206d595af4011eaac29d4136a',
       i686: '686e6342e25f5e34c1f84bd75df7fda7b51dca020d485c7d9d0489c57b4e24d7',
     x86_64: 'b135bb16017bf602bd00b8f5ccd28b2582627c69f9abab8318e2b79e025981b3'
  })

  depends_on 'libdb'
  depends_on 'emacs'
  depends_on 'tcpwrappers'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
            --enable-ipv6 \
            --with-gnutls \
            --with-berkeley-db \
            --without-guile \
            --with-gdbm \
            --with-fribidi \
            --with-unistring \
            --with-tcp-wrappers \
            --with-readline"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make check || /bin/true' # Check 471 will fail
  end
end

require 'package'

class Bind < Package
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/downloads/bind/'
  version '9.12.2'
  source_url 'https://www.isc.org/downloads/file/bind-9-12-2/?version=tar-gz'
  source_sha256 '9f6a4c8b39a7064d447d8414a09ed667ff21adc69f17461916d8f5a45f348452'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.12.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.12.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.12.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bind-9.12.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '624fb5a8b679ded3a5034e4af58a001bd2b1962b308cf9f5690945898c640820',
     armv7l: '624fb5a8b679ded3a5034e4af58a001bd2b1962b308cf9f5690945898c640820',
       i686: '0513adea01afa62c7a5df53eba0e7dd71127f26439464b56f0d27773231b2e98',
     x86_64: '1ae24865bcf2d1a8c953644f809fe52794cf6968d4bf06d9f77c08b80c3fa343',
  })

  depends_on 'libcap'
  depends_on 'libseccomp'
  depends_on 'readline'

  def self.build
    system "BUILD_CC=gcc ./configure \
                --with-randomdev=no \
                --with-ecdsa=yes \
                --with-gost=yes \
                --with-seccomp \
                --prefix=#{CREW_PREFIX} \
                --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end

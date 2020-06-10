require 'package'

class Mpc < Package
  description 'Gnu Mpc is a C library for the arithmetic of complex numbers with arbitrarily high precision and correct rounding of the result.'
  homepage 'http://www.multiprecision.org/'
  version '1.1.0'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/mpc/mpc-1.1.0.tar.gz'
  source_sha256 '6985c538143c1208dcb1ac42cedad6ff52e267b47e5f970183a3e75125b43c2e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mpc-1.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mpc-1.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mpc-1.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mpc-1.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '93e218f15597b7fcbd6291986597e4c391e521d4f71ac19d815267cffcdeaf07',
     armv7l: '93e218f15597b7fcbd6291986597e4c391e521d4f71ac19d815267cffcdeaf07',
       i686: 'c952ab3fc51d56c6b0140534627888769f3a1bde43a645b279b9ef1010c7080f',
     x86_64: '1fe81b949e466649174009019f96fbc09ea5161dfc99f0d5e462da196b5b64a1',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

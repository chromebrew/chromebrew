require 'package'

class Libidn2 < Package
  description 'GNU Libidn is a fully documented implementation of the Stringprep, Punycode and IDNA 2003 specifications.'
  homepage 'https://www.gnu.org/software/libidn/'
  version '2.3.0'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libidn/libidn2-2.3.0.tar.gz'
  source_sha256 'e1cb1db3d2e249a6a3eb6f0946777c2e892d5c5dc7bd91c74394fc3a01cab8b5'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libidn2-2.3.0-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libidn2-2.3.0-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libidn2-2.3.0-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libidn2-2.3.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '7614e912f8122d6a2a3b779f4c16f0e74029dd1213ea9d38ed7b6ee6d19f3de6',
      armv7l: '7614e912f8122d6a2a3b779f4c16f0e74029dd1213ea9d38ed7b6ee6d19f3de6',
        i686: 'eed21b95d8c8d236acfc87e40cf6aa605a6ceb6894b2c0f331e8955e2897a617',
      x86_64: '06c9f3803f02ce792550a39a1de3253b74ca6622b2543f843727f31dc4aa0f46',
  })

  def self.build
    system 'autoreconf -i -f'
    system "sed -i 's,/usr/bin/file,#{CREW_PREFIX}/bin/file,g' configure"
    system "./configure #{CREW_OPTIONS} \
           --enable-shared"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

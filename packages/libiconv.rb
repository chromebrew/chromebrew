require 'package'

class Libiconv < Package
  description 'GNU charset conversion library for libc which does not implement it.'
  homepage 'https://www.gnu.org/software/libiconv/'
  version '1.16-1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libiconv/libiconv-1.16.tar.gz'
  source_sha256 'e6a1b1b589654277ee790cce3734f07876ac4ccfaecbee8afa0b649cf529cc04'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6746c57dfa263dd4a4e32a3246f0ca97bee9c15075fd84f5dfbe4cf872ddcc2e',
     armv7l: '6746c57dfa263dd4a4e32a3246f0ca97bee9c15075fd84f5dfbe4cf872ddcc2e',
       i686: 'f43a3150b8427b719e0a810426490b84bd4c9b2c9dddc0141ac10b543029dbeb',
     x86_64: '449564c5ca12cc7f78241c3d9df8476b0f449fdc3930f01f7c3a6506ae3eb1a2',
  })

  def self.build
    system "./configure #{CREW_OPTIONS} --enable-static --enable-relocatable --enable-extra-encodings"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

require 'package'

class Freetype < Package
  description 'FreeType is a freely available software library to render fonts.'
  homepage 'https://www.freetype.org/'
  version '2.8'
  source_url 'http://download.savannah.gnu.org/releases/freetype/freetype-2.8.tar.bz2'
  source_sha256 'a3c603ed84c3c2495f9c9331fe6bba3bb0ee65e06ec331e0a0fb52158291b40b'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/freetype-2.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/freetype-2.8-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/freetype-2.8-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/freetype-2.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5ec39b82a7b680abf3a42cb460e885452e32f54c00f3e59fb7b284ab78cf7bd0',
     armv7l: '5ec39b82a7b680abf3a42cb460e885452e32f54c00f3e59fb7b284ab78cf7bd0',
       i686: 'f76398ca157ba8e311f750352e4914fa143c1b6f46f5d74f85f8658fc0afe906',
     x86_64: '1015587a901348072e4315afdfdf9901ff2d7d2f671cfe54023407bc8836dcb6',
  })

  def self.build
      system "./configure CFLAGS=\" -fPIC\""
      system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

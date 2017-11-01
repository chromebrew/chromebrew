require 'package'

class Freetype < Package
  description 'FreeType is a freely available software library to render fonts.'
  homepage 'https://www.freetype.org/'
  version '2.8-1'
  source_url 'http://download.savannah.gnu.org/releases/freetype/freetype-2.8.tar.bz2'
  source_sha256 'a3c603ed84c3c2495f9c9331fe6bba3bb0ee65e06ec331e0a0fb52158291b40b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.8-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.8-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.8-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.8-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '58621598c0709365f4b3ca410f7a50970923dc2321854329849d7a040943ba90',
     armv7l: '58621598c0709365f4b3ca410f7a50970923dc2321854329849d7a040943ba90',
       i686: '05ad35d74ec47427e358928f9aff083c711f4af39b8f84aced44b15d91048397',
     x86_64: 'ff9281a9a5bac7c32ddb8a27620ebab461380994f17517cc62c11b3dbee89773',
  })

  depends_on 'expat'

  def self.build
      system "./configure CFLAGS=\" -fPIC\""
      system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

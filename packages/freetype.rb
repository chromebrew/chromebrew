require 'package'

class Freetype < Package
  description 'FreeType is a freely available software library to render fonts.'
  homepage 'https://www.freetype.org/'
  version '2.10.4'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/freetype/freetype-2.10.4.tar.xz'
  source_sha256 '86a854d8905b19698bbc8f23b860bc104246ce4854dcea8e3b0fb21284f75784'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.10.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.10.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.10.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.10.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c3063feb7034883e248ac4d62a82409df69577ccc4abe38ca7bd7e39c5ed3576',
     armv7l: 'c3063feb7034883e248ac4d62a82409df69577ccc4abe38ca7bd7e39c5ed3576',
       i686: 'a53b10cf19f25922aa6cc0f09fe846e5ee7221c73f2288ca04f83529191a94f5',
     x86_64: '4622df673ffd07fdcec9591f039ad6e89c4687517678adb6f964dbfdff6a39cf',
  })

  depends_on 'expat'
  depends_on 'libpng'   # freetype needs zlib optionally. zlib is also the dependency of libpng
  depends_on 'bz2'
  depends_on 'harfbuzz'

  def self.build
    system 'pip3 install docwriter'
    system "sed -i 's,/usr/include/freetype2,#{CREW_PREFIX}/include/freetype2,g' configure"
    system "./configure CFLAGS=' -fPIC' #{CREW_OPTIONS} --enable-freetype-config --with-harfbuzz"
    system 'make'
    system 'pip3 uninstall docwriter -y'
    system "pip3 install docwriter --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

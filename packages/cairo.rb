require 'package'

class Cairo < Package
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.14.12-1'
  source_url 'https://www.cairographics.org/releases/cairo-1.14.12.tar.xz'
  source_sha256 '8c90f00c500b2299c0a323dd9beead2a00353752b2092ead558139bd67f7bf16'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.14.12-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.14.12-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.14.12-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.14.12-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '39ed1c001a51c6041b8f6e8454cc9cf2563e9d992f124d5266ca384e4932bc92',
     armv7l: '39ed1c001a51c6041b8f6e8454cc9cf2563e9d992f124d5266ca384e4932bc92',
       i686: '6e37fb090daa853dd24857eddfdad7f613a48efadd203f6fb147758fb68b1b33',
     x86_64: 'b36c865cef3deb8c3c52dd5b0ac51a3a9811a12ce91fde4196d6a2cb289f3faa',
  })

  depends_on 'libpng'
  depends_on 'pixman'
  depends_on 'fontconfig' # pango requires cairo with fontconfig
  depends_on 'libtool'
  depends_on 'mesa'
  depends_on 'automake' => :build

  def self.build
    system "./autogen.sh"   # This fixes automake error (when we directly use configure)
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --enable-xlib \
            --enable-xlib-xcb \
            --enable-glesv2"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

require 'package'

class Libcaca < Package
  description 'libcaca is a graphics library that outputs text instead of pixels, so that it can work on older video cards or text terminals.'
  homepage 'http://caca.zoy.org/wiki/libcaca'
  version '0.99.beta19-1'
  compatibility 'all'
  source_url 'http://caca.zoy.org/files/libcaca/libcaca-0.99.beta19.tar.gz'
  source_sha256 '128b467c4ed03264c187405172a4e83049342cc8cc2f655f53a2d0ee9d3772f4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libcaca-0.99.beta19-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libcaca-0.99.beta19-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libcaca-0.99.beta19-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libcaca-0.99.beta19-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '72232772de316927a7222e5adca9809165f6aae02dcd2d82347bbb750eff0b62',
     armv7l: '72232772de316927a7222e5adca9809165f6aae02dcd2d82347bbb750eff0b62',
       i686: 'dbd6341f7dc376baf948c3e25c323bf923796c9bb79a846a4c8ddf0ff0be5f12',
     x86_64: 'fc4454b4934dc0d5ac1b08402b3a73a53d8bfe0cb0da23a72ef46166465f5124',
  })

  depends_on 'imlib2'
  depends_on 'libx11'
  depends_on 'ncurses'
  depends_on 'slang'

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --enable-ncurses \
            --enable-slang \
            --enable-x11 \
            --with-x"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

require 'package'

class Cairo < Package
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.15.10-0'
  source_url 'https://fossies.org/linux/misc/cairo-1.15.10.tar.xz'
  source_sha256 '62ca226134cf2f1fd114bea06f8b374eb37f35d8e22487eaa54d5e9428958392'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.15.10-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.15.10-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.15.10-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.15.10-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '198c368f87760cfa8702a9b4ad8c9abd338cf18cdbfea01257434ddff9c81812',
     armv7l: '198c368f87760cfa8702a9b4ad8c9abd338cf18cdbfea01257434ddff9c81812',
       i686: '3e6482d16a21bd17d3a78c68b6b2d724d529c1763bd998efd8924c37bd378c96',
     x86_64: '1cf92bcaf00709c297227f6f2ac1388d06f8978a89fc6207ba1ab0cee7a777fd',
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

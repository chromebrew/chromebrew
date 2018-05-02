require 'package'

class Cairo < Package
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.15.12'
  source_url 'https://fossies.org/linux/misc/cairo-1.15.12.tar.xz'
  source_sha256 '7623081b94548a47ee6839a7312af34e9322997806948b6eec421a8c6d0594c9'


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

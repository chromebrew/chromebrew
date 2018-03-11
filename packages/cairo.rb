require 'package'

class Cairo < Package
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.15.10-0'
  source_url 'https://fossies.org/linux/misc/cairo-1.15.10.tar.xz'
  source_sha256 '62ca226134cf2f1fd114bea06f8b374eb37f35d8e22487eaa54d5e9428958392'

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

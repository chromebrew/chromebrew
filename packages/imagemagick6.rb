require 'package'

class Imagemagick6 < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '6.9.10-77'
  source_url 'https://www.imagemagick.org/download/releases/ImageMagick-6.9.10-77.tar.xz'
  source_sha256 '55b3ef6281056c728a25e178434f1e7a2e491cbd99e44dc090a82967a2df6e11'

  binary_url ({
  })
  binary_sha256 ({
  })

  if ARGV[0] == 'install'
    imver = `stream -version 2> /dev/null | head -1 | cut -d' ' -f3`.chomp
    abort "ImageMagick version #{imver} already installed.".lightgreen unless "#{imver}" == ""
  end

  depends_on 'flif'
  depends_on 'freetype'
  depends_on 'ghostscript'
  depends_on 'graphviz'
  depends_on 'jbigkit'
  depends_on 'jemalloc'
  depends_on 'lzma'
  depends_on 'libheif'
  depends_on 'librsvg'
  depends_on 'libwebp'
  depends_on 'libwmf'
  depends_on 'msttcorefonts'
  depends_on 'openexr'
  depends_on 'openjpeg'
  depends_on 'pango'
  depends_on 'python27'
  depends_on 'zstd'
  depends_on 'sommelier'

  def self.patch
    system 'filefix'
  end

  def self.build
    system "CFLAGS=' -I#{CREW_PREFIX}/include/gdk-pixbuf-2.0 -I#{CREW_PREFIX}/include/c++/v1/support/xlocale' \
           ./configure \
           --prefix=#{CREW_PREFIX} \
           --libdir=#{CREW_LIB_PREFIX} \
           --disable-dependency-tracking \
           --with-windows-font-dir=#{CREW_PREFIX}/share/fonts/truetype/msttcorefonts \
           --with-jemalloc \
           --with-modules \
           --enable-hdri \
           --with-perl \
           --with-rsvg \
           --with-x"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libMagickWand-6.Q16HDRI.so.6", "#{CREW_DEST_LIB_PREFIX}/libMagickWand-6.Q16.so.6"
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libMagickCore-6.Q16HDRI.so.6", "#{CREW_DEST_LIB_PREFIX}/libMagickCore-6.Q16.so.6"
  end
  
end

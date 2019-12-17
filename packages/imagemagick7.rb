require 'package'

class Imagemagick7 < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '7.0.9-7'
  source_url 'https://www.imagemagick.org/download/releases/ImageMagick-7.0.9-7.tar.xz'
  source_sha256 '73398cc626ebbb060d0df552b0db75de0c334f9626286284b627a6eb2a66ed19'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick7-7.0.9-7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick7-7.0.9-7-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick7-7.0.9-7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '234aa27aeb1f8bb7cdcfb9d9d84d4d249aa2346d00206d79df708de784115f17',
     armv7l: '234aa27aeb1f8bb7cdcfb9d9d84d4d249aa2346d00206d79df708de784115f17',
     x86_64: '515e0c51741e5ffe791f456ae0a5fcc090d0dce6799d2d4f96d858ddc612da83',
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
    system "ln -s #{CREW_LIB_PREFIX}/libMagickWand-7.Q16HDRI.so.6 #{CREW_LIB_PREFIX}/libMagickWand-7.Q16.so.6"
    system "ln -s #{CREW_LIB_PREFIX}/libMagickCore-7.Q16HDRI.so.6 #{CREW_LIB_PREFIX}/libMagickCore-7.Q16.so.6"
  end

  def self.remove
    system "rm #{CREW_LIB_PREFIX}/libMagickWand-7.Q16.so.6"
    system "rm #{CREW_LIB_PREFIX}/libMagickCore-7.Q16.so.6"
  end
end

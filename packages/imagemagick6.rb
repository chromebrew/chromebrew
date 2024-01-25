require 'buildsystems/autotools'

class Imagemagick6 < Autotools
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '6.9.13-1'
  license 'imagemagick'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/ImageMagick/ImageMagick6.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '02c86e07210e37fe812a47c3307f2adb128f842776e9bc579052e49eedae6fe0',
     armv7l: '02c86e07210e37fe812a47c3307f2adb128f842776e9bc579052e49eedae6fe0',
     x86_64: '7548ee592c236c1f21b1f732cffff7b60f72937bc28ffdc07a074285ac005e9f'
  })

  depends_on 'flif'
  depends_on 'freeimage'
  depends_on 'freetype'
  depends_on 'ghostscript'
  depends_on 'graphviz'
  depends_on 'jbigkit'
  depends_on 'jemalloc'
  depends_on 'xzutils'
  depends_on 'libheif'
  depends_on 'librsvg'
  depends_on 'libwebp'
  depends_on 'libwmf'
  depends_on 'msttcorefonts'
  depends_on 'openexr'
  depends_on 'openjpeg'
  depends_on 'pango'
  depends_on 'python2'
  depends_on 'zstd'
  depends_on 'sommelier'

  def self.preinstall
    imver = `stream -version 2> /dev/null | head -1 | cut -d' ' -f3`.chomp
    abort "ImageMagick version #{imver} already installed.".lightgreen unless imver.to_s == ''
  end

  pre_configure_options "CFLAGS=' -I#{CREW_PREFIX}/include/gdk-pixbuf-2.0 -I#{CREW_PREFIX}/include/c++/v1/support/xlocale'"

  configure_options "--disable-dependency-tracking \
    --with-windows-font-dir=#{CREW_PREFIX}/share/fonts/truetype/msttcorefonts \
    --with-jemalloc \
    --with-modules \
    --enable-hdri \
    --with-perl \
    --with-rsvg \
    --with-x"

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libMagickWand-6.Q16HDRI.so.6", "#{CREW_DEST_LIB_PREFIX}/libMagickWand-6.Q16.so.6"
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libMagickCore-6.Q16HDRI.so.6", "#{CREW_DEST_LIB_PREFIX}/libMagickCore-6.Q16.so.6"
  end
end

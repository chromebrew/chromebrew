require 'package'

class Imagemagick6 < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '6.9.11-29'
  license 'imagemagick'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://github.com/ImageMagick/ImageMagick6/archive/6.9.11-29.tar.gz'
  source_sha256 'f425e31f64cb481a1416a037d88d04eb44236bef83334e55b7ad692f71c61270'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/imagemagick6/6.9.11-29_armv7l/imagemagick6-6.9.11-29-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/imagemagick6/6.9.11-29_armv7l/imagemagick6-6.9.11-29-chromeos-armv7l.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/imagemagick6/6.9.11-29_x86_64/imagemagick6-6.9.11-29-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd30b0f8132c26bb5a31160c046dec64b6ee5a6060130c17fdfe2546cef1c01f2',
     armv7l: 'd30b0f8132c26bb5a31160c046dec64b6ee5a6060130c17fdfe2546cef1c01f2',
     x86_64: '5a247589c82be8fde96ee189ffbe12f5b72bb7398d341b80245222bab568af07'
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

  def self.patch
    system 'filefix'
  end

  def self.build
    system "CFLAGS=' -I#{CREW_PREFIX}/include/gdk-pixbuf-2.0 -I#{CREW_PREFIX}/include/c++/v1/support/xlocale' \
           ./configure \
           --prefix=#{CREW_PREFIX} \
           --libdir=#{CREW_LIB_PREFIX} \
           --mandir=#{CREW_MAN_PREFIX} \
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

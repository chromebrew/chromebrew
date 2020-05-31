require 'package'

class Imagemagick6 < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '6.9.10-79'
  source_url 'https://imagemagick.org/download/ImageMagick-6.9.10-79.tar.xz'
  source_sha256 '52b7bf07175feca8da112a093661baa7fe7453eb8c576d8f904135cc3c15567e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.10-79-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.10-79-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.10-79-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e9a0befa3e96a9a42ec9bcc66b597aefd6ff6e4d68f3138772a6deadfa2ce769',
     armv7l: 'e9a0befa3e96a9a42ec9bcc66b597aefd6ff6e4d68f3138772a6deadfa2ce769',
     x86_64: '16dec45ba5036a192c42ac1c46bd8744682e6a6cd1e19c576c911e9511fbc078',
  })

  depends_on 'flif'
  depends_on 'freeimage'
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

  def self.preinstall
    imver = `stream -version 2> /dev/null | head -1 | cut -d' ' -f3`.chomp
    abort "ImageMagick version #{imver} already installed.".lightgreen unless "#{imver}" == ""
  end

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

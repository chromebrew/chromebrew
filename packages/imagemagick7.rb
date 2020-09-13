require 'package'

class Imagemagick7 < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '7.0.10-29'
  compatibility 'aarch64,armv7l,x86_64'
  case ARCH
  when 'aarch64', 'armv7l', 'x86_64'
    source_url 'https://github.com/ImageMagick/ImageMagick/archive/7.0.10-29.tar.gz'
    source_sha256 '7a3a3347e8b0dae2396663c879644cebcb8d4ed115645b4c9dba66494022b2fd'
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
  end

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick7-7.0.10-29-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick7-7.0.10-29-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick7-7.0.10-29-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2b36714b61050e4da65ccaf8860cf654d13f530122edbb21edd5e633f07db297',
     armv7l: '2b36714b61050e4da65ccaf8860cf654d13f530122edbb21edd5e633f07db297',
     x86_64: '8557c63c17dcfe443d9ed6e8d78aa555cf032b4165ec39157bb209581c0daf41',
  })

  def self.preinstall
    imver = `stream -version 2> /dev/null | head -1 | cut -d' ' -f3`.chomp
    abort "ImageMagick version #{imver} already installed.".lightgreen unless "#{imver}" == ""
  end

  def self.patch
    system 'filefix'
  end

  def self.build
    system "./configure",
           "CFLAGS=-I#{CREW_PREFIX}/include/gdk-pixbuf-2.0 -I#{CREW_PREFIX}/include/c++/v1/support/xlocale",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--mandir=#{CREW_MAN_PREFIX}",
           "--with-windows-font-dir=#{CREW_PREFIX}/share/fonts/truetype/msttcorefonts",
           '--disable-dependency-tracking',
           '--with-jemalloc',
           '--with-modules',
           '--enable-hdri',
           '--with-perl',
           '--with-rsvg',
           '--with-x'
    system 'make' 
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libMagickWand-7.Q16HDRI.so.6", "#{CREW_DEST_LIB_PREFIX}/libMagickWand-7.Q16.so.6"
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libMagickCore-7.Q16HDRI.so.6", "#{CREW_DEST_LIB_PREFIX}/libMagickCore-7.Q16.so.6"
  end
end

require 'package'

class Imagemagick7 < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  @_ver = '7.0.11-2'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/ImageMagick/ImageMagick/archive/#{@_ver}.tar.gz"
  source_sha256 '936959ba77bb9d8fdab4d9c69f90316c02a7e2467dea3790ad36b4d500c31a22'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick7-7.0.11-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick7-7.0.11-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick7-7.0.11-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick7-7.0.11-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '04025f5ae6e216cf6e79f2c1a6eccc79ee4a3228eb4d13d9475938a031bb1986',
     armv7l: '04025f5ae6e216cf6e79f2c1a6eccc79ee4a3228eb4d13d9475938a031bb1986',
       i686: '2a8cae3b4c308c75078f199e8bb9b005baf0babfdce0ff9f5b5f52b23ca71fa0',
     x86_64: '8bc32c289e65e5499660cda89afab1dfb68b14de9c70b4f3e82924fa3dafe80a'
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

  def self.preinstall
    imver = `stream -version 2> /dev/null | head -1 | cut -d' ' -f3`.chomp
    abort "ImageMagick version #{imver} already installed.".lightgreen unless imver.to_s == ''
  end

  def self.patch
    system 'filefix'
  end

  def self.build
    system "env CFLAGS='-pipe -flto=auto -fno-stack-protector -U_FORTIFY_SOURCE \
      -I#{CREW_PREFIX}/include/gdk-pixbuf-2.0 \
      -I#{CREW_PREFIX}/include/c++/v1/support/xlocale' \
      CXXFLAGS='-pipe -flto=auto -fno-stack-protector -U_FORTIFY_SOURCE' \
      LDFLAGS='-flto=auto -fno-stack-protector -U_FORTIFY_SOURCE' \
      ./configure \
      #{CREW_OPTIONS} \
      --mandir=#{CREW_MAN_PREFIX} \
      --program-prefix='' \
      --with-windows-font-dir=#{CREW_PREFIX}/share/fonts/truetype/msttcorefonts \
      --disable-dependency-tracking \
      --enable-hugepages \
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
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libMagickWand-7.Q16HDRI.so.6", "#{CREW_DEST_LIB_PREFIX}/libMagickWand-7.Q16.so.6"
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libMagickCore-7.Q16HDRI.so.6", "#{CREW_DEST_LIB_PREFIX}/libMagickCore-7.Q16.so.6"
  end
end

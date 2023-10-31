require 'package'

class Imagemagick7 < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  @_ver = '7.1.1-3'
  version "#{@_ver}-perl5.34"
  license 'imagemagick'
  compatibility 'all'
  source_url 'https://github.com/ImageMagick/ImageMagick.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/imagemagick7/7.1.1-3-perl5.34_armv7l/imagemagick7-7.1.1-3-perl5.34-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/imagemagick7/7.1.1-3-perl5.34_armv7l/imagemagick7-7.1.1-3-perl5.34-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/imagemagick7/7.1.1-3-perl5.34_i686/imagemagick7-7.1.1-3-perl5.34-chromeos-i686.tar.zst',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/imagemagick7/7.1.1-3-perl5.34_x86_64/imagemagick7-7.1.1-3-perl5.34-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'cc275b254e3f1bfafb8bace8227a2d07cf2d7dacd15619915ccdd48b9470acc2',
     armv7l: 'cc275b254e3f1bfafb8bace8227a2d07cf2d7dacd15619915ccdd48b9470acc2',
       i686: '9156bfdd7c388a8d0895317ef8b1347991ea3925b933bf426521d6f51f6c3686',
    x86_64: 'ed0e5cdf87a45c8c01e501022e49d045df5bb6f0b3e74111f1131c00a418a350'
  })

  depends_on 'bzip2' # R
  depends_on 'flif' => :build
  depends_on 'fontconfig' => :build
  depends_on 'freeimage' => :build
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'ghostscript' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'graphviz' # R
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'ilmbase' # R
  depends_on 'jbigkit' => :build
  depends_on 'jemalloc' # R
  depends_on 'lcms' # R
  depends_on 'libbsd' # R
  depends_on 'libdeflate' # R
  depends_on 'libheif' => :build
  depends_on 'libice' # R
  depends_on 'libmd' # R
  depends_on 'libpng' # R
  depends_on 'librsvg' # R
  depends_on 'libsm' # R
  depends_on 'libtiff' # R
  depends_on 'libtool' # R
  depends_on 'libwebp' # R
  depends_on 'libwmf' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxext' # R
  depends_on 'libxml2' # R
  depends_on 'libxt' # R
  depends_on 'msttcorefonts' # L
  depends_on 'openexr' # R
  depends_on 'openjpeg' # R
  depends_on 'pango' # R
  depends_on 'util_linux' # R
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R
  depends_on 'expat' # R
  depends_on 'fontconfig' # R
  depends_on 'libjpeg' # R

  def self.preinstall
    imver = `stream -version 2> /dev/null | head -1 | cut -d' ' -f3`.chomp
    abort "ImageMagick version #{imver} already installed.".lightgreen unless imver.to_s == ''
  end

  def self.patch
    system 'filefix'
  end

  def self.build
    system "./configure \
      #{CREW_OPTIONS} \
      --mandir=#{CREW_MAN_PREFIX} \
      --program-prefix='' \
      --with-windows-font-dir=#{CREW_PREFIX}/share/fonts/truetype/msttcorefonts \
      --disable-dependency-tracking \
      --with-magick-plus-plus \
      --enable-hugepages \
      --with-jemalloc \
      --with-modules \
      --enable-hdri \
      --with-perl \
      --with-perl-options='INSTALLDIRS=vendor' \
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

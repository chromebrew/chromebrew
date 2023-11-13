require 'buildsystems/autotools'

class Imagemagick7 < Autotools
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  @_ver = '7.1.1-21'
  version "#{@_ver}-perl5.38"
  license 'imagemagick'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/ImageMagick/ImageMagick.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/imagemagick7/7.1.1-21-perl5.38_armv7l/imagemagick7-7.1.1-21-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/imagemagick7/7.1.1-21-perl5.38_armv7l/imagemagick7-7.1.1-21-perl5.38-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/imagemagick7/7.1.1-21-perl5.38_x86_64/imagemagick7-7.1.1-21-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bc6fea71d9dfc086cb5518d4226e05669a341be55abe3921adb89373f075577b',
     armv7l: 'bc6fea71d9dfc086cb5518d4226e05669a341be55abe3921adb89373f075577b',
     x86_64: 'a1594d54dd328ac01753b02a3f6e0d92d87e811f779edc33dcd02b8f130d9443'
  })

  depends_on 'bzip2' # R
  depends_on 'cairo' # R
  depends_on 'expat' # R
  depends_on 'flif' => :build
  depends_on 'fontconfig' # R
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
  depends_on 'jbigkit' # R
  depends_on 'jemalloc' # R
  depends_on 'lcms' # R
  depends_on 'libbsd' # R
  depends_on 'libdeflate' # R
  depends_on 'libheif' # R
  depends_on 'libice' # R
  depends_on 'libjpeg' # R
  depends_on 'libjxl' # R
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

  def self.preinstall
    imver = `stream -version 2> /dev/null | head -1 | cut -d' ' -f3`.chomp
    abort "ImageMagick version #{imver} already installed.".lightgreen unless imver.to_s == ''
  end

  configure_options "--mandir=#{CREW_MAN_PREFIX} \
      --program-prefix='' \
      --with-windows-font-dir=#{CREW_PREFIX}/share/fonts/truetype/msttcorefonts \
      --with-magick-plus-plus \
      --enable-hugepages \
      --with-jemalloc \
      --with-modules \
      --enable-hdri \
      --with-perl \
      --with-perl-options='INSTALLDIRS=vendor' \
      --with-rsvg \
      --with-x"

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libMagickWand-7.Q16HDRI.so.6", "#{CREW_DEST_LIB_PREFIX}/libMagickWand-7.Q16.so.6"
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libMagickCore-7.Q16HDRI.so.6", "#{CREW_DEST_LIB_PREFIX}/libMagickCore-7.Q16.so.6"
  end
end

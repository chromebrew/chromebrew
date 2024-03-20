require 'buildsystems/autotools'

class Imagemagick7 < Autotools
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  @_ver = '7.1.1-23'
  version "#{@_ver}-perl5.38"
  license 'imagemagick'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/ImageMagick/ImageMagick.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fefbb13329799de2d4d62eca465c7fd5ac086386cc1e35d0b362605041e9b598',
     armv7l: 'fefbb13329799de2d4d62eca465c7fd5ac086386cc1e35d0b362605041e9b598',
     x86_64: '7c0a0c4340d25380efd0fabe2eb92c2b87ce49141b79cf696aaf7be9fc187ecc'
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

  no_upstream_update

  def self.preinstall
    imver = `stream -version 2> /dev/null | head -1 | cut -d' ' -f3`.chomp
    abort "ImageMagick version #{imver} already installed.".lightgreen unless imver.to_s == ''
  end

  configure_options "--mandir=#{CREW_MAN_PREFIX} \
      --program-prefix='' \
      --with-windows-font-dir=#{CREW_PREFIX}/share/fonts/truetype/msttcorefonts \
      --enable-hugepages \
      --with-jemalloc \
      --with-modules \
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

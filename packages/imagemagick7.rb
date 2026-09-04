require 'buildsystems/autotools'

class Imagemagick7 < Autotools
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version "7.1.2-31-#{CREW_PERL_VER}"
  license 'imagemagick'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ImageMagick/ImageMagick.git'
  # The imagemagick7 version always has a dash in it.
  git_hashtag version.reverse.split('-', 2).collect(&:reverse).reverse.first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1e568efd14ef986365ad603be30b27feda30ab4ad7afd85de8e58fe155cf62c4',
     armv7l: '1e568efd14ef986365ad603be30b27feda30ab4ad7afd85de8e58fe155cf62c4',
     x86_64: 'f310b6a5c25061846f27138bac9fe41b89560d3b62843894c4d96babf9eaf590'
  })

  depends_on 'bzip2' => :library
  depends_on 'cairo' => :library
  depends_on 'flif' => :build
  depends_on 'fontconfig' => :library
  depends_on 'freeimage' => :build
  depends_on 'freetype' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'ghostscript' => :build
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'graphviz' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'jbigkit' => :library
  depends_on 'jemalloc' => :library
  depends_on 'lcms' => :library
  depends_on 'libbsd' => :executable
  depends_on 'libdeflate' # R
  depends_on 'libheif' => :library
  depends_on 'libice' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libjxl' => :library
  depends_on 'libpng' => :library
  depends_on 'librsvg' => :library
  depends_on 'libsm' => :library
  depends_on 'libtiff' => :library
  depends_on 'libtool' => :library
  depends_on 'libwebp' => :library
  depends_on 'libwmf' => :library
  depends_on 'libx11' => :library
  depends_on 'libxau' => :executable
  depends_on 'libxcb' => :executable
  depends_on 'libxdmcp' => :executable
  depends_on 'libxext' => :library
  depends_on 'libxml2' => :library
  depends_on 'libxt' => :library
  depends_on 'msttcorefonts' => :logical
  depends_on 'openexr' => :library
  depends_on 'openjpeg' => :library
  depends_on 'pango' => :library
  depends_on 'util_linux' => :executable
  depends_on 'xzutils' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' # R

  conflicts_with 'graphicsmagick'

  def self.prebuild
    ConvenienceFunctions.libtoolize('jbig', 'jbigkit')
    ConvenienceFunctions.libtoolize('libpng')
    ConvenienceFunctions.libtoolize('libuuid', 'util_linux')
  end

  def self.preinstall
    imver = `stream -version 2> /dev/null | head -1 | cut -d' ' -f3`.chomp
    abort "ImageMagick version #{imver} already installed.".lightgreen unless imver.to_s == ''
  end

  autotools_configure_options "--mandir=#{CREW_MAN_PREFIX} \
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

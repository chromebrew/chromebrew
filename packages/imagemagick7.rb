require 'package'

class Imagemagick7 < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  @_ver = '7.1.0-37'
  version @_ver
  license 'imagemagick'
  compatibility 'all'
  source_url 'https://github.com/ImageMagick/ImageMagick.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/imagemagick7/7.1.0-37_armv7l/imagemagick7-7.1.0-37-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/imagemagick7/7.1.0-37_armv7l/imagemagick7-7.1.0-37-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/imagemagick7/7.1.0-37_i686/imagemagick7-7.1.0-37-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/imagemagick7/7.1.0-37_x86_64/imagemagick7-7.1.0-37-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '734c1dde282b695f90ad9a7af940a088ff91eefcb30189fbcb0b89d5eb14bd3a',
     armv7l: '734c1dde282b695f90ad9a7af940a088ff91eefcb30189fbcb0b89d5eb14bd3a',
       i686: '1f0490156c755f3328b6881641251292332ca527bd5fdfa757bf3190f1982dc8',
     x86_64: '7f9e553d8b73ba2339a800d8668f80d9518879dbf3c2296e55e14f4ebd190edb'
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
  depends_on 'libpng'
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

require 'package'

class Imagemagick7 < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  @_ver = '7.1.0-19'
  version @_ver
  license 'imagemagick'
  compatibility 'all'
  source_url 'https://github.com/ImageMagick/ImageMagick.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/imagemagick7/7.1.0-19_armv7l/imagemagick7-7.1.0-19-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/imagemagick7/7.1.0-19_armv7l/imagemagick7-7.1.0-19-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/imagemagick7/7.1.0-19_i686/imagemagick7-7.1.0-19-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/imagemagick7/7.1.0-19_x86_64/imagemagick7-7.1.0-19-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e4ab61bc827580630719cdcd95036bff97375f7626deaea8a22e2cb8ffdde9a1',
     armv7l: 'e4ab61bc827580630719cdcd95036bff97375f7626deaea8a22e2cb8ffdde9a1',
       i686: 'f112987ecd6c6c5be4632ae7f3b953a30d2a4ad1ebeeb92d51d006a300a887cb',
     x86_64: 'f3f60b31f682ce39b3fc56bb7a3f44d5fd0fcb87c37e0951080fc57dbc852757'
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

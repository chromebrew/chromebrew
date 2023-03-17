require 'package'

class Ghostscript < Package
  description 'Interpreter for the PostScript language'
  homepage 'https://www.ghostscript.com/'
  version '10.0.0'
  license 'AGPL-3+'
  compatibility 'all'
  source_url 'https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs1000/ghostpdl-10.0.0.tar.xz'
  source_sha256 '8f2b7941f60df694b4f5c029b739007f7c4e0d43858471ae481e319a967d5d8b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ghostscript/10.0.0_armv7l/ghostscript-10.0.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ghostscript/10.0.0_armv7l/ghostscript-10.0.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ghostscript/10.0.0_i686/ghostscript-10.0.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ghostscript/10.0.0_x86_64/ghostscript-10.0.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '82c15db8a46f73fcf467fd36bdc1d9713bfe35e1fd269408a75232967400ebf4',
     armv7l: '82c15db8a46f73fcf467fd36bdc1d9713bfe35e1fd269408a75232967400ebf4',
       i686: '91dfb5bab16d31c3418c57cae464f0b2377f0e19d0057cec751ef8b14f50b9aa',
     x86_64: 'c3c1f1ac1c31ea6a465367504156c18d47bae8b1ecbaee3b118e3bbc3b25a5a9'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' => :build
  depends_on 'cups' # R
  depends_on 'expat' # R
  depends_on 'fontconfig' => :build
  depends_on 'freetype' # R
  depends_on 'gcc' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' unless ARCH == 'i686' # R
  depends_on 'harfbuzz' # R
  depends_on 'lcms' # R
  depends_on 'libarchive' # R
  depends_on 'libice' # R
  depends_on 'libjpeg' # R
  depends_on 'libpaper' # R
  depends_on 'libpng' # R
  depends_on 'libsm' # R
  depends_on 'libtiff' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxt' # R
  depends_on 'openjpeg' # R
  depends_on 'pango' # R
  depends_on 'zlibpkg' # R

  def self.patch
    system 'rm -r cups/libs expat ijs jpeg lcms2mt libpng openjpeg tiff zlib'
  end

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system 'filefix'
    system "./configure #{CREW_OPTIONS} \
      --disable-compile-inits \
      --enable-dynamic \
      --enable-fontconfig \
      --enable-freetype \
      --enable-openjpeg \
      --with-drivers=ALL \
      --with-fontpath=#{CREW_PREFIX}/share/fonts/gsfonts \
      --with-ijs \
      --with-jbig2dec \
      --with-libpaper \
      --with-openprinting \
      --without-luratech \
      --with-system-libtiff \
      --with-x"
    system 'make'
    system 'make so' # Make libgs
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "make soinstall DESTDIR=#{CREW_DEST_DIR}" # Install libgs
    FileUtils.cp_r Dir.glob('./base/*.h'), "#{CREW_DEST_PREFIX}/include/ghostscript"
    FileUtils.ln_sf 'ghostscript', "#{CREW_DEST_PREFIX}/include/ps"
  end
end

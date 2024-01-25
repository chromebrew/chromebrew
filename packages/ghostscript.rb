require 'package'

class Ghostscript < Package
  description 'Interpreter for the PostScript language'
  homepage 'https://www.ghostscript.com/'
  version '10.02.0'
  license 'AGPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs10020/ghostpdl-10.02.0.tar.xz'
  source_sha256 'c158f3b5ade88227510a42652e0fe7b2aa48e123c1fd663cb03e3d87ca2db86a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd6788673f00998758405cc8aab3b29a0184c9abaf40c2177600f779ca5222c4a',
     armv7l: 'd6788673f00998758405cc8aab3b29a0184c9abaf40c2177600f779ca5222c4a',
     x86_64: '04b66919323c4660ddbbfcb9f255a3ba0de73e540a956abc10650978d9abe6f1'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' => :build
  depends_on 'cups' # R
  depends_on 'expat' # R
  depends_on 'fontconfig' => :build
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'jbigkit' => :build
  depends_on 'lcms' # R
  depends_on 'libarchive' # R
  depends_on 'libice' # R
  depends_on 'libjpeg' # R
  depends_on 'libpaper' # R
  depends_on 'libpng' # R
  depends_on 'libsm' # R
  depends_on 'libtiff' # R
  depends_on 'libvdpau' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxt' # R
  depends_on 'neon' # R
  depends_on 'openjpeg' # R
  depends_on 'pango' # R
  depends_on 'zlibpkg' # R

  no_lto

  def self.patch
    FileUtils.rm_rf %w[cups/libs expat ijs jpeg lcms2mt libpng openjpeg tiff zlib]
  end

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system 'filefix'
    system "./configure #{CREW_OPTIONS} \
      --disable-hidden-visibility \
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
      --with-system-libtiff"
    system 'make'
    system 'make so' # Make libgs
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "make soinstall DESTDIR=#{CREW_DEST_DIR}" # Install libgs
    FileUtils.cp_r Dir['./base/*.h'], "#{CREW_DEST_PREFIX}/include/ghostscript"
    FileUtils.ln_sf 'ghostscript', "#{CREW_DEST_PREFIX}/include/ps"
  end
end

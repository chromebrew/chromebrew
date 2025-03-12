require 'package'

class Ghostscript < Package
  description 'Interpreter for the PostScript language'
  homepage 'https://www.ghostscript.com/'
  version '10.05.0'
  license 'AGPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs#{version.tr('.', '')}/ghostpdl-#{version}.tar.xz"
  source_sha256 '0603f5629bc6f567b454911d104cd96702489c9e70e577787843f480b23d4a77'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ebadc4e1e882398f800455434158d3260d61d32e42f647b6f9d803c8d750d2c3',
     armv7l: 'ebadc4e1e882398f800455434158d3260d61d32e42f647b6f9d803c8d750d2c3',
     x86_64: 'e97d4b792adf25187c89103b3f9b85df5cb98dbe56135742033922bb41177a13'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'cups' # R
  depends_on 'expat' # R
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'jbigkit' => :build
  depends_on 'lcms' # R
  depends_on 'libice' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpaper' # R
  depends_on 'libpng' # R
  depends_on 'libsm' # R
  depends_on 'libtiff' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxt' # R
  depends_on 'openjpeg' # R
  depends_on 'pango' # R
  depends_on 'zlib' # R

  no_lto

  def self.patch
    FileUtils.rm_rf %w[cups/libs expat ijs jpeg lcms2mt libpng openjpeg tiff zlib]
  end

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system 'filefix'
    system "./configure #{CREW_CONFIGURE_OPTIONS} \
      --disable-hidden-visibility \
      --disable-compile-inits \
      --disable-neon \
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

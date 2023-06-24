require 'package'

class Ghostscript < Package
  description 'Interpreter for the PostScript language'
  homepage 'https://www.ghostscript.com/'
  version '10.01.2'
  license 'AGPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs10012/ghostpdl-10.01.2.tar.xz'
  source_sha256 'b535600c968f672b4f6750e7eac57623fc7f80eb8c00a0175a46010942cf0e9c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ghostscript/10.01.2_armv7l/ghostscript-10.01.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ghostscript/10.01.2_armv7l/ghostscript-10.01.2-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ghostscript/10.01.2_x86_64/ghostscript-10.01.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9280c8b0efd59665c590e806c749799be1b54d3905d194f0bcaf21cdfcb7e11a',
     armv7l: '9280c8b0efd59665c590e806c749799be1b54d3905d194f0bcaf21cdfcb7e11a',
     x86_64: '7fb1df4334f2707290a7a8f26781960f17464b7fd53059113085b3b474c8b12d'
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

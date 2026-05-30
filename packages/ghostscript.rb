require 'buildsystems/autotools'

class Ghostscript < Autotools
  description 'Interpreter for the PostScript language'
  homepage 'https://www.ghostscript.com/'
  version '10.07.1'
  license 'AGPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'git://git.ghostscript.com/ghostpdl.git'
  git_hashtag "ghostpdl-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '70532561af7b9397afedadd4e004c198d8c8cfd8d269c27e20e485f3e57cffc5',
     armv7l: '70532561af7b9397afedadd4e004c198d8c8cfd8d269c27e20e485f3e57cffc5',
     x86_64: 'c3eceae2c5f813c4cae0d64d699afff72d338b6043b976f8df4fb5b1bf770df1'
  })

  depends_on 'at_spi2_core' => :executable
  depends_on 'brotli' => :library
  depends_on 'cairo' => :executable
  depends_on 'cups' => :library
  depends_on 'expat' => :library
  depends_on 'fontconfig' => :library
  depends_on 'freetype' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gtk3' => :executable
  depends_on 'harfbuzz' => :executable
  depends_on 'jbigkit' => :build
  depends_on 'lcms' => :library
  depends_on 'libice' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libpaper' => :library
  depends_on 'libpng' => :library
  depends_on 'libsm' => :library
  depends_on 'libtiff' => :library
  depends_on 'libx11' => :library
  depends_on 'libxext' => :library
  depends_on 'libxt' => :library
  depends_on 'openjpeg' => :library
  depends_on 'pango' => :executable
  depends_on 'zlib' => :library

  no_lto

  def self.patch
    FileUtils.rm_rf %w[brotli cups/libs expat ijs jpeg lcms2mt libpng openjpeg tiff zlib]
  end

  autotools_configure_options " \
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
    --with-system-brotli \
    --with-system-libtiff"

  autotools_build_extras do
    system 'make so' # Make libg
  end

  autotools_install_extras do
    system "make soinstall DESTDIR=#{CREW_DEST_DIR}" # Install libgs
    FileUtils.cp_r Dir['./base/*.h'], "#{CREW_DEST_PREFIX}/include/ghostscript"
    FileUtils.ln_sf 'ghostscript', "#{CREW_DEST_PREFIX}/include/ps"
  end
end

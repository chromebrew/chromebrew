require 'package'

class Ghostscript < Package
  description 'Interpreter for the PostScript language'
  homepage 'https://www.ghostscript.com/'
  version '10.01.1'
  license 'AGPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs10011/ghostpdl-10.01.1.tar.xz'
  source_sha256 'e6a6c39a36e6b6ffe4960f4e2bfb85420ed157ac14a202ccdd0df4e4e2a7e392'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ghostscript/10.01.1_armv7l/ghostscript-10.01.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ghostscript/10.01.1_armv7l/ghostscript-10.01.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ghostscript/10.01.1_x86_64/ghostscript-10.01.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '708dcba34f11085f789bbb2ecbf9b85a7bc9218d1780f0f68983e73adf6d61fb',
     armv7l: '708dcba34f11085f789bbb2ecbf9b85a7bc9218d1780f0f68983e73adf6d61fb',
     x86_64: '5042fba200abc52486a404aa44acc0e85c8be5c48f0f7a0e667a3a22afef1b54'
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
  depends_on 'gtk3' unless ARCH == 'i686' # R
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

  no_env_options

  def self.patch
    FileUtils.rm_rf %w[cups/libs expat ijs jpeg lcms2mt libpng openjpeg tiff zlib]
  end

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system 'filefix'
    @x = ARCH == 'i686' ? '--with-x' : ''
    # LTO fails with
    # lto1: internal compiler error: resolution sub id 0xe18903a85a5b05ae not in object file
    system "#{CREW_ENV_FNO_LTO_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} ./configure #{CREW_OPTIONS} \
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
      --with-system-libtiff \
      #{@x}"
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

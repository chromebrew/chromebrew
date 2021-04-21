require 'package'

class Ghostscript < Package
  description 'Interpreter for the PostScript language'
  homepage 'https://www.ghostscript.com/'
  version '9.54'
  license 'AGPL-3+'
  compatibility 'all'
  source_url 'https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs9540/ghostpdl-9.54.0.tar.xz'
  source_sha256 'ecbaa2e79e6d82cab8d0fbdfd899aa4fc68ffb43f6901d547d33ca7008fe1871'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/ghostscript-9.54-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/ghostscript-9.54-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/ghostscript-9.54-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/ghostscript-9.54-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a2fee20357654918f2deac0d7af356c84898e282d008906ede6b424fd95fd549',
     armv7l: 'a2fee20357654918f2deac0d7af356c84898e282d008906ede6b424fd95fd549',
       i686: 'f68277f2d042311835bf70828dcae6ce281d5cb376e4d525d63e1858012ab30d',
     x86_64: '92ac6123594ea3fe04474e7654785a599f65b57884f5931b71bfeb63100b0741'
  })

  depends_on 'atk'
  depends_on 'cairo'
  depends_on 'cups'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gtk3'
  depends_on 'harfbuzz'
  depends_on 'lcms'
  depends_on 'libice'
  depends_on 'libjpeg'
  depends_on 'libpaper'
  depends_on 'libpng'
  depends_on 'libsm'
  depends_on 'libtiff'
  depends_on 'libx11'
  depends_on 'libxext'
  depends_on 'libxt'
  depends_on 'openjpeg'
  depends_on 'pango'

  case ARCH
  when 'armv7l', 'aarch64'
    @ltoflags = ''
  when 'x86_64', 'i686'
    @ltoflags = '-flto'
  end

  def self.patch
    system 'rm -r cups/libs expat ijs jpeg lcms2mt libpng openjpeg tiff zlib'
  end

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system 'filefix'
    system "env CFLAGS='-pipe -fuse-ld=gold #{@ltoflags}' \
      CXXFLAGS='-pipe -fuse-ld=gold #{@ltoflags}' \
      ./configure #{CREW_OPTIONS} \
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

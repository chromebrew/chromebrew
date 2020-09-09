require 'package'

class Ghostscript < Package
  description 'Interpreter for the PostScript language'
  homepage 'https://www.ghostscript.com/'
  version '9.52'
  compatibility 'all'
  source_url 'https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs952/ghostscript-9.52.tar.xz'
  source_sha256 '57442acf8b46453a9b5fc6fec738fbbb7e13a3d3e00f1aaaa0975529bc203c7c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ghostscript-9.52-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ghostscript-9.52-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ghostscript-9.52-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ghostscript-9.52-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5a3ae66fa14e6b58b61e7375fb8796330a991305a7f448ffa7636392f3bc5df0',
     armv7l: '5a3ae66fa14e6b58b61e7375fb8796330a991305a7f448ffa7636392f3bc5df0',
       i686: 'c05ca55a65c57d6d084be7ea407dd96d068ca2ac7c7e78bd48d0e79cbff4703a',
     x86_64: '09dfcff8a2477779f9d8dcb677bcda0b99b5064cb343d56495b51240d2a0f988',
  })

  depends_on 'dbus'
  depends_on 'fontconfig'
  depends_on 'jasper'
  depends_on 'gsfonts'
  depends_on 'lcms'
  depends_on 'libxext'
  depends_on 'libxt'
  depends_on 'openjpeg'
  depends_on 'libpaper'
  depends_on 'cups'

  def self.build
    system "CPPFLAGS='-DPNG_ARM_NEON_OPT=0' ./configure #{CREW_OPTIONS} --disable-dependency-tracking -disable-static"
    system 'make'
    system "make so" # Make libgs
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "make soinstall DESTDIR=#{CREW_DEST_DIR}" # Install libgs
    FileUtils.cp_r Dir.glob('./base/*.h'), "#{CREW_DEST_PREFIX}/include/ghostscript"
    FileUtils.ln_sf 'ghostscript', "#{CREW_DEST_PREFIX}/include/ps"
  end
end

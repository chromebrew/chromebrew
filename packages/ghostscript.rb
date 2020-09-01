require 'package'

class Ghostscript < Package
  description 'Interpreter for the PostScript language'
  homepage 'https://www.ghostscript.com/'
  version '9.52'
  compatibility 'all'
  source_url 'https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs952/ghostscript-9.52.tar.xz'
  source_sha256 '57442acf8b46453a9b5fc6fec738fbbb7e13a3d3e00f1aaaa0975529bc203c7c'

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

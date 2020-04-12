require 'package'

class Ghostscript < Package
  description 'Ghostscript is the name of a set of software that provides an interpreter for the PostScript language and the PDF file format.'
  homepage 'https://www.ghostscript.com/'
  version '9.52'
  case ARCH
  when 'i686', 'x86_64'
    source_url 'https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs952/ghostscript-9.52.tar.xz'
    source_sha256 '57442acf8b46453a9b5fc6fec738fbbb7e13a3d3e00f1aaaa0975529bc203c7c'
  end

  binary_url ({
      i686: 'https://dl.bintray.com/chromebrew/chromebrew/ghostscript-9.52-chromeos-i686.tar.xz',
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ghostscript-9.52-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
      i686: 'e03c125fcc7a4a0bbc9e73cc96b2c9f32f7e20e5791e68f8a81cae6d667da789',
    x86_64: 'df1b614750f332fb8d759fe5b9c5c231193d745abc0c47db493470fa7d40e459',
  })

  depends_on 'cups'
  depends_on 'gtk3'
  depends_on 'lcms'
  depends_on 'libpng'
  depends_on 'libtiff'

  def self.build
    system "./configure #{CREW_OPTIONS} --with-drivers=ALL"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

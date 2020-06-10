require 'package'

class Ghostscript < Package
  description 'Ghostscript is the name of a set of software that provides an interpreter for the PostScript language and the PDF file format.'
  homepage 'https://www.gnu.org/software/ghostscript/'
  version '9.14.1-1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/ghostscript/gnu-ghostscript-9.14.1.tar.xz'
  source_sha256 '424a4ff333a594fdd397cd8adc4249bad7d74a6ae653f840dee72b27f1bf1da0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ghostscript-9.14.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ghostscript-9.14.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ghostscript-9.14.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ghostscript-9.14.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'eb8e98fe8b0eb70ce20c56878e962d690f25703326cdca60865ed05e5444cd3f',
     armv7l: 'eb8e98fe8b0eb70ce20c56878e962d690f25703326cdca60865ed05e5444cd3f',
       i686: '31827f5362971f99ba3aa5aa6f4fdc3a4ca4368bf72a499538fdf7f98fff3d41',
     x86_64: '23325d5f8c5cbb538a366313d68da5a35677ddf963ecfdfe8a40d0617c55b2bc',
  })

  depends_on 'cups'
  depends_on 'gtk3'
  depends_on 'lcms'
  depends_on 'libpng'
  depends_on 'libtiff'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-dependency-tracking',
           '--disable-static'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

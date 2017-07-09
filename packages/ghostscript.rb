require 'package'

class Ghostscript < Package
  description 'Ghostscript is the name of a set of software that provides an interpreter for the PostScript language and the PDF file format.'
  homepage 'https://www.gnu.org/software/ghostscript/'
  version '9.14.1'
  source_url 'ftp://ftp.gnu.org/gnu/ghostscript/gnu-ghostscript-9.14.1.tar.xz'
  source_sha256 '424a4ff333a594fdd397cd8adc4249bad7d74a6ae653f840dee72b27f1bf1da0'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/ghostscript-9.14.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/ghostscript-9.14.1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/ghostscript-9.14.1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/ghostscript-9.14.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1b6fba1f2c7ff6ecd0403e4270d63ce3951ae690431b56994f2940970f0f6d1c',
     armv7l: '1b6fba1f2c7ff6ecd0403e4270d63ce3951ae690431b56994f2940970f0f6d1c',
       i686: '22999822bd89cb27f7c8dd5f8c90d002e2459f888fbc397cb74df00ea359ff87',
     x86_64: '3313fbc9dcb40dd371db2147bd3ef00baeb3dbfb97420430ea4b7ef42d101d1e',
  })

  depends_on 'lcms'
  depends_on 'libjpeg'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

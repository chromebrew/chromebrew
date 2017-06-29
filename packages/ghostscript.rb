require 'package'

class Ghostscript < Package
  description 'Ghostscript is the name of a set of software that provides an interpreter for the PostScript language and the PDF file format.'
  homepage 'https://www.gnu.org/software/ghostscript/'
  version '9.14.1'
  source_url 'ftp://ftp.gnu.org/gnu/ghostscript/gnu-ghostscript-9.14.1.tar.xz'
  source_sha256 '424a4ff333a594fdd397cd8adc4249bad7d74a6ae653f840dee72b27f1bf1da0'

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

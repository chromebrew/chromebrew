require 'package'

class Pdfchain < Package
  description 'PDF Chain is a graphical user interface for the PDF Toolkit (PDFtk).'
  homepage 'https://pdfchain.sourceforge.io/'
  version '0.4.4.2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/pdfchain/pdfchain-0.4.4.2/pdfchain-0.4.4.2.tar.gz'
  source_sha256 '1eee0f93dbe8c9cef9f9fe4ec0a10e0a45ca8cde67cd6ceffa2ce6c843752f3d'
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: 'b052c791dab36fb8a87e9abd77be1695cfe1246093b222a3f83a74f9f3d8ca3a',
     armv7l: 'b052c791dab36fb8a87e9abd77be1695cfe1246093b222a3f83a74f9f3d8ca3a',
       i686: 'd983a44e676ee973c5d4f67c597d5ba1ca8419ab4081a89b3823f60052bce2fd',
     x86_64: 'a3cdadfccb70459207f0bf61b81df07697e33c8fe04c009a5878470e29661008'
  })

  depends_on 'libunwind'
  depends_on 'pdftk'
  depends_on 'gtkmm3'
  depends_on 'valgrind'
  depends_on 'sommelier'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    puts "\nType 'pdfchain' to get started.\n".lightblue
  end
end

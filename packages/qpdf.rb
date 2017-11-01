require 'package'

class Qpdf < Package
  description 'QPDF is a command-line program that does structural, content-preserving transformations on PDF files.'
  homepage 'http://qpdf.sourceforge.net/'
  version '7.0.b1'
  source_url 'https://github.com/qpdf/qpdf/archive/release-qpdf-7.0.b1.tar.gz'
  source_sha256 '2e0a26f7a03fe41c72be8e95c420744f98dbf553e025fb0d4c990f83df023d90'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './autogen.sh'
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

require 'package'

class Qpdf < Package
  description 'QPDF is a command-line program that does structural, content-preserving transformations on PDF files.'
  homepage 'http://qpdf.sourceforge.net/'
  version '7.0.b1'
  source_url 'https://github.com/qpdf/qpdf/archive/release-qpdf-7.1.1.tar.gz'
  source_sha256 '21822dc365eaee55bc449d84eb760b9845c4871783ab0e4c4f3b244052718a1a'

  binary_url ({
  })
  binary_sha256 ({
  })
  
  depends_on 'libjpeg'

  def self.build
    system './autogen.sh'
    system './configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

require 'package'

class Lha < Package
  description 'LHa for UNIX is a console-based utility that uncompresses and compresses .lha packages.'
  homepage 'http://freecode.com/projects/lhaforunix'
  version '1.14i-ac20050924p1'
  source_url 'http://prdownloads.sourceforge.jp/lha/22231/lha-1.14i-ac20050924p1.tar.gz'
  source_sha256 'b5261e9f98538816aa9e64791f23cb83f1632ecda61f02e54b6749e9ca5e9ee4'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

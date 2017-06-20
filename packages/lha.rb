require 'package'

class Lha < Package
  description 'LHa for UNIX is a console-based utility that uncompresses and compresses .lha packages.'
  homepage 'http://freecode.com/projects/lhaforunix'
  version '1.14i-ac20040929'
  source_url 'http://prdownloads.sourceforge.jp/lha/11617/lha-1.14i-ac20040929.tar.gz'
  source_sha1 '2e2eb1ee84fe3fa804fd80e6777d4a30050e017f'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

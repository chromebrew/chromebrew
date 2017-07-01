require 'package'

class Lha < Package
  description 'LHa for UNIX is a console-based utility that uncompresses and compresses .lha packages.'
  homepage 'http://freecode.com/projects/lhaforunix'
  version '1.14i-ac20040929'
  source_url 'http://prdownloads.sourceforge.jp/lha/11617/lha-1.14i-ac20040929.tar.gz'
  source_sha256 '6da392c63768c931c038cab7cd9939a2b05d390bff6922cc45faeed7b7530b8b'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

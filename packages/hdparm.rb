require 'package'

class Hdparm < Package
  description 'hdparm is a GNU/Linux shell utility for viewing and manipulating various IDE drive and driver parameters.'
  homepage 'https://directory.fsf.org/wiki/Hdparm'
  version '9.55'
  source_url 'https://sourceforge.net/projects/hdparm/files/hdparm/hdparm-9.55.tar.gz'
  source_sha256 'b5c76b732483df36bf08001a209b95b45558016615f935008e5ea91a7fde6dc7'

  depends_on 'glibc'

  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
end

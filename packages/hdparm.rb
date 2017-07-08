require 'package'

class Hdparm < Package
  description 'hdparm is a GNU/Linux shell utility for viewing and manipulating various IDE drive and driver parameters.'
  homepage 'https://directory.fsf.org/wiki/Hdparm'
  version '9.32'
  source_url 'http://www.ibiblio.org/pub/Linux/system/hardware/hdparm-9.32.tar.gz'
  source_sha256 '90d80632695759ec12c8a9da94471f04bc88d5b73d34fc6a370775b534d09319'

  def self.build
    system "sed -i 's,binprefix = ,binprefix = /usr/local,' Makefile"
    system "sed -i 's,manprefix = /usr,manprefix = /usr/local,' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "-e", "install"
  end
end

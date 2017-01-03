require 'package'
 
class Groff < Package
  version '1.22.3'
  source_url 'http://ftp.gnu.org/gnu/groff/groff-1.22.3.tar.gz'
  source_sha1 '61a6808ea1ef715df9fa8e9b424e1f6b9fa8c091'
  
  def self.build
    system './configure'
    system 'make'
  end
  
  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

require 'package'
 
class Libpipeline < Package
  version '1.4.1'
  source_url 'https://download.savannah.gnu.org/releases/libpipeline/libpipeline-1.4.1.tar.gz'
  source_sha1 'b31cc955f22b1aa4545dc8d00ddbde831936594f'
  
  def self.build
    system './configure'
    system 'make'
  end
  
  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

require 'package'

class Libtasn1 < Package
  version '4.10'
  source_url 'https://ftp.gnu.org/gnu/libtasn1/libtasn1-4.10.tar.gz'
  source_sha1 'c7b36fa50866bbc889f7503c7fd1e9f9d7c52a64'
  
  
  def self.build
    system "make"
    
    end
    
  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
  
end

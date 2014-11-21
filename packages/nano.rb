require 'package'

class Nano < Package
  version '2.3.6'
  source_url 'ftp://ftp.gnu.org/pub/gnu/nano/nano-2.3.6.tar.gz' # software source tarball url  
  source_sha1 '7dd39f21bbb1ab176158e0292fd61c47ef681f6d'

  depends_on 'buildessential'
  depends_on 'ncurses' 
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure CPPFLAGS=\"-I/usr/local/include/ncurses\""
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end         
end

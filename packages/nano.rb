require 'package'

class Nano < Package
  version '2.7.1'
  source_url 'ftp://ftp.gnu.org/pub/gnu/nano/nano-2.7.1.tar.gz' # software source tarball url  
  source_sha1 '5ad089d08e68dc7977f51403de6d7872686647af'

  depends_on 'buildessential'
  depends_on 'ncurses' 
  depends_on 'libmagic'
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure CPPFLAGS=\"-I/usr/local/include/ncurses\""
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end         
end

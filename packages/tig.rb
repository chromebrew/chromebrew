require 'package'                                                      	# include package class file
 
class Tig < Package                                            	# name the package and make it a Package class instance
  version '1.9a'                                               	                                      # software version
  source_url 'http://jonas.nitro.dk/tig/releases/tig-2.0.2.tar.gz'     # software source tarball url
  source_sha1 'de01c3a52952172e42ae642d97a55505d7e09efd'          	# source tarball sha1 sum
  
  depends_on 'readline'                                            # software dependencies
  depends_on 'ncurses'
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "CPPFLAGS=-I/usr/local/include/ncurses ./configure"
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end                                                             # during installation
end

require 'package'                                                      	# include package class file
 
class Tig < Package                                            	# name the package and make it a Package class instance
  description 'Tig is an ncurses-based text-mode interface for git.'
  homepage 'http://jonas.nitro.dk/tig/'
  version '2.2.1'                                               	                                      # software version
  source_url 'https://github.com/jonas/tig/archive/tig-2.2.1.tar.gz'     # software source tarball url
  source_sha1 '704e35ad3f54024d7ce14dade4294aacc0744b3d'          	# source tarball sha1 sum
  
  depends_on 'readline'                                            # software dependencies
  depends_on 'ncurses'
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./autogen.sh"
    system "./configure", "--prefix=/usr/local"
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end                                                             # during installation
end

require 'package'                                                      	# include package class file
 
class Tmux < Package                                            	# name the package and make it a Package class instance
  version '1.9a'                                               	                                      # software version
  source_url 'http://downloads.sourceforge.net/tmux/tmux-1.9a.tar.gz'     # software source tarball url
  source_sha1 '815264268e63c6c85fe8784e06a840883fcfc6a2'          	# source tarball sha1 sum
  
  depends_on 'readline'                                            # software dependencies
  depends_on 'libevent'
  depends_on 'ncurses'
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "CPPFLAGS=-I/usr/local/include/ncurses ./configure"
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end                                                             # during installation
end

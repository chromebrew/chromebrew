require 'package'                                                      	# include package class file
 
class Tmux < Package                                            	# name the package and make it a Package class instance
  version '2.2'                                               	                                      # software version
  source_url 'https://github.com/tmux/tmux/releases/download/2.2/tmux-2.2.tar.gz'     # software source tarball url
  source_sha1 '5ed1430bc7ef44c227e64e9401c686573dd0791a'          	# source tarball sha1 sum
  
  depends_on 'readline'                                            # software dependencies
  depends_on 'libevent'
  # does this really depend on openssl?  or just on libevent that depends on openssl
  depends_on 'openssl'
  depends_on 'ncurses'
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "CPPFLAGS=-I/usr/local/include/ncurses ./configure"
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end                                                             # during installation
end

require 'package'                                                      	# include package class file
 
class Libevent < Package                                            	# name the package and make it a Package class instance
  version '2.1.8'                                               	                                      # software version
  source_url 'https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz'     # software source tarball url
  source_sha1 '2a1b8bb7a262d3fd0ed6a080a20991a6eed675ec'          	# source tarball sha1 sum
  depends_on 'openssl'
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure"
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end                                                             # during installation
end

require 'package'                                                      	# include package class file
 
class Libevent < Package                                            	# name the package and make it a Package class instance
  version '2.0.21'                                               	                                      # software version
  source_url 'https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz'     # software source tarball url
  source_sha1 '3e6674772eb77de24908c6267c698146420ab699'          	# source tarball sha1 sum
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure"
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end                                                             # during installation
end

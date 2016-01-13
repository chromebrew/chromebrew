require 'package'                                                      	# include package class file
 
class Sqlite < Package                                            	# name the package and make it a Package class instance
  version '3.10'                                               	                                      # software version
  source_url 'http://www.sqlite.org/2016/sqlite-autoconf-3100000.tar.gz'     # software source tarball url
  source_sha1 '7be6e6869d0d2d9fe3df71b5c65f065dd2325f58'          	# source tarball sha1 sum

  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure"
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end                                                             # during installation
end

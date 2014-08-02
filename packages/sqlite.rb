require 'package'                                                      	# include package class file
 
class Sqlite < Package                                            	# name the package and make it a Package class instance
  version '3.8.5'                                               	                                      # software version
  source_url 'https://www.sqlite.org/2014/sqlite-autoconf-3080500.tar.gz'     # software source tarball url
  source_sha1 '7f667e10ccebc26ab2086b8a30cb0a600ca0acae'          	# source tarball sha1 sum
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure"
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end                                                             # during installation
end

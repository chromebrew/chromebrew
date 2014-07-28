require 'package'                                                      	# include package class file
 
class Ctags < Package                                            	# name the package and make it a Package class instance
  version '5.8'                                               	                                      # software version
  source_url 'http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz'     # software source tarball url
  source_sha1 '482da1ecd182ab39bbdc09f2f02c9fba8cd20030'          	# source tarball sha1 sum
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure"
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end                                                             # during installation
end

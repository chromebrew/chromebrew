require 'package'                                                      	# include package class file
 
class Leveldb < Package                                            	# name the package and make it a Package class instance
  version '1.15.0'                                               	                                      # software version
  source_url 'https://leveldb.googlecode.com/files/leveldb-1.15.0.tar.gz'     # software source tarball url
  source_sha1 '74b70a1156d91807d8d84bfdd026e0bb5acbbf23'          	# source tarball sha1 sum
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "mkdir", "-p", "#{CREW_DEST_DIR}/usr/local/include"
    system "mkdir", "-p", "#{CREW_DEST_DIR}/usr/local/lib"
    system "cp", "-R", "include/leveldb", "#{CREW_DEST_DIR}/usr/local/include"
    system "cp", "libleveldb.a", "#{CREW_DEST_DIR}/usr/local/lib"
    system "cp", "libleveldb.so.1.15", "#{CREW_DEST_DIR}/usr/local/lib"
    system "cp", "-P", "libleveldb.so.1", "#{CREW_DEST_DIR}/usr/local/lib"
    system "cp", "-P", "libleveldb.so", "#{CREW_DEST_DIR}/usr/local/lib"
  end                                                             # during installation
end

require 'package'                                                      	# include package class file
 
class Leveldb < Package                                            	# name the package and make it a Package class instance
  description 'LevelDB is a fast key-value storage library written at Google that provides an ordered mapping from string keys to string values.'
  homepage 'https://leveldb.googlecode.com/'
  version '1.19.0'                                               	                                      # software version
  source_url 'https://github.com/google/leveldb/archive/v1.19.tar.gz'     # software source tarball url
  source_sha1 '864b45b4a8d1ad400b9115ff6d3c9fb1f79be82b'          	# source tarball sha1 sum
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "mkdir", "-p", "#{CREW_DEST_DIR}/usr/local/include"
    system "mkdir", "-p", "#{CREW_DEST_DIR}/usr/local/lib"
    system "cp", "-R", "include/leveldb", "#{CREW_DEST_DIR}/usr/local/include"
    system "cp", "out-static/libleveldb.a", "#{CREW_DEST_DIR}/usr/local/lib"
    system "cp", "out-shared/libleveldb.so.1.19", "#{CREW_DEST_DIR}/usr/local/lib"
    system "cp", "-P", "out-shared/libleveldb.so.1", "#{CREW_DEST_DIR}/usr/local/lib"
    system "cp", "-P", "out-shared/libleveldb.so", "#{CREW_DEST_DIR}/usr/local/lib"
  end                                                             # during installation
end

require 'package'
 
class Leveldb < Package
  description 'LevelDB is a fast key-value storage library written at Google that provides an ordered mapping from string keys to string values.'
  homepage 'https://leveldb.googlecode.com/'
  version '1.19.0'
  source_url 'https://github.com/google/leveldb/archive/v1.19.tar.gz'
  source_sha1 '864b45b4a8d1ad400b9115ff6d3c9fb1f79be82b'
  
  def self.build
    system "make"
  end
  
  def self.install
    system "mkdir", "-p", "#{CREW_DEST_DIR}/usr/local/include"
    system "mkdir", "-p", "#{CREW_DEST_DIR}/usr/local/lib"
    system "cp", "-R", "include/leveldb", "#{CREW_DEST_DIR}/usr/local/include"
    system "cp", "out-static/libleveldb.a", "#{CREW_DEST_DIR}/usr/local/lib"
    system "cp", "out-shared/libleveldb.so.1.19", "#{CREW_DEST_DIR}/usr/local/lib"
    system "cp", "-P", "out-shared/libleveldb.so.1", "#{CREW_DEST_DIR}/usr/local/lib"
    system "cp", "-P", "out-shared/libleveldb.so", "#{CREW_DEST_DIR}/usr/local/lib"
  end                                                             # during installation
end

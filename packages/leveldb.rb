require 'package'

class Leveldb < Package
  description 'LevelDB is a fast key-value storage library written at Google that provides an ordered mapping from string keys to string values.'
  homepage 'https://leveldb.googlecode.com/'
  version '1.20'
  source_url 'https://github.com/google/leveldb/archive/v1.20.tar.gz'
  source_sha256 'f5abe8b5b209c2f36560b75f32ce61412f39a2922f7045ae764a2c23335b6664'

  def self.build
    system "make"
  end

  def self.install
    system "mkdir", "-p", "#{CREW_DEST_DIR}/usr/local/include"
    system "mkdir", "-p", "#{CREW_DEST_DIR}/usr/local/lib"
    system "cp", "-R", "include/leveldb", "#{CREW_DEST_DIR}/usr/local/include"
    system "cp", "out-static/libleveldb.a", "#{CREW_DEST_DIR}/usr/local/lib"
    system "cp", "out-shared/libleveldb.so.1.20", "#{CREW_DEST_DIR}/usr/local/lib"
    system "cp", "-P", "out-shared/libleveldb.so.1", "#{CREW_DEST_DIR}/usr/local/lib"
    system "cp", "-P", "out-shared/libleveldb.so", "#{CREW_DEST_DIR}/usr/local/lib"
  end
end

require 'package'

class Leveldb < Package
  description 'LevelDB is a fast key-value storage library written at Google that provides an ordered mapping from string keys to string values.'
  homepage 'https://leveldb.googlecode.com/'
  version '1.20-1'
  source_url 'https://github.com/google/leveldb/archive/v1.20.tar.gz'
  source_sha256 'f5abe8b5b209c2f36560b75f32ce61412f39a2922f7045ae764a2c23335b6664'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/leveldb-1.20-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/leveldb-1.20-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/leveldb-1.20-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/leveldb-1.20-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '78469e16d2864c8f544710f8dca294bada2528be5f7db2a8a87dcd6e3567b625',
     armv7l: '78469e16d2864c8f544710f8dca294bada2528be5f7db2a8a87dcd6e3567b625',
       i686: '08e120b94bc11785ba2bc78418c2e76211e606939873d7b7d4f55a2c3baef049',
     x86_64: '2f81ee50689c02e67f608f717d4956aee5106bea929c0498eb2b751f8c46b512',
  })

  def self.build
    system 'make'
  end

  def self.install
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/include"
    system "mkdir", "-p", "#{CREW_DEST_LIB_PREFIX}"
    system "cp", "-R", "include/leveldb", "#{CREW_DEST_PREFIX}/include"
    system "cp", "out-static/libleveldb.a", "#{CREW_DEST_LIB_PREFIX}"
    system "cp", "out-shared/libleveldb.so.1.20", "#{CREW_DEST_LIB_PREFIX}"
    system "cp", "-P", "out-shared/libleveldb.so.1", "#{CREW_DEST_LIB_PREFIX}"
    system "cp", "-P", "out-shared/libleveldb.so", "#{CREW_DEST_LIB_PREFIX}"
  end
end

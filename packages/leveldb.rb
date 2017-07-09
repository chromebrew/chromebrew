require 'package'

class Leveldb < Package
  description 'LevelDB is a fast key-value storage library written at Google that provides an ordered mapping from string keys to string values.'
  homepage 'https://leveldb.googlecode.com/'
  version '1.20'
  source_url 'https://github.com/google/leveldb/archive/v1.20.tar.gz'
  source_sha256 'f5abe8b5b209c2f36560b75f32ce61412f39a2922f7045ae764a2c23335b6664'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/leveldb-1.20-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/leveldb-1.20-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/leveldb-1.20-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/leveldb-1.20-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5b9e78ff11fdecae8b1a58b7724d1dc8481a5d85e72146a20df7fc6611d745b7',
     armv7l: '5b9e78ff11fdecae8b1a58b7724d1dc8481a5d85e72146a20df7fc6611d745b7',
       i686: '8aa1fe8444debfe38540b2b194f7ec2d1be224557291343aa54588d9fd01f805',
     x86_64: 'd8a33a4ee417d1f95ca0ac9e4f50bb3e262a5334f3cf37ed0eae7cf15681476c',
  })

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

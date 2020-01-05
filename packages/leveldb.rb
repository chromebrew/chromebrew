require 'package'

class Leveldb < Package
  description 'LevelDB is a fast key-value storage library written at Google that provides an ordered mapping from string keys to string values.'
  homepage 'https://leveldb.googlecode.com/'
  version '1.22'
  source_url 'https://github.com/google/leveldb/archive/1.22.tar.gz'
  source_sha256 '55423cac9e3306f4a9502c738a001e4a339d1a38ffbee7572d4a07d5d63949b2'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'snappy'

  def self.build
    FileUtils.mkdir 'build'
    FileUtils.cd('build') do
      system "cmake .. -DCMAKE_BUILD_TYPE=Release \
                       -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
                       -DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX} \
                       -DBUILD_SHARED_LIBS=1"
      system 'make'
    end
  end

  def self.install
    system "make -C build DESTDIR=#{CREW_DEST_DIR} install"
  end

  def self.check
    system 'make -C build test'
  end
end

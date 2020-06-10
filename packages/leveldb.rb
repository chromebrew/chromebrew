require 'package'

class Leveldb < Package
  description 'LevelDB is a fast key-value storage library written at Google that provides an ordered mapping from string keys to string values.'
  homepage 'https://leveldb.googlecode.com/'
  version '1.22'
  compatibility 'all'
  source_url 'https://github.com/google/leveldb/archive/1.22.tar.gz'
  source_sha256 '55423cac9e3306f4a9502c738a001e4a339d1a38ffbee7572d4a07d5d63949b2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/leveldb-1.22-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/leveldb-1.22-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/leveldb-1.22-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/leveldb-1.22-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '362de886138261f127b60e31644ac80c627d9aba40e027c9d92978337c327915',
     armv7l: '362de886138261f127b60e31644ac80c627d9aba40e027c9d92978337c327915',
       i686: '1722af2fe019a295d63f72cb56fa75a69cc618a90e6013aef8d1a3572cc6c3de',
     x86_64: 'a9a4f292b4d9ae782a7763b03cf62ae2bdd12944f5ccd82e5fd4c0780d74bdca',
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

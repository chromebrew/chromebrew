require 'package'

class Superlu < Package
  description 'SuperLU is a general purpose library for the direct solution of large, sparse, nonsymmetric systems of linear equations.'
  homepage 'https://portal.nersc.gov/project/sparse/superlu/'
  version '5.2.1'
  compatibility 'all'
  source_url 'https://github.com/xiaoyeli/superlu/archive/v5.2.1.tar.gz'
  source_sha256 '77582501dedef295eb74e4dc9433e2816d2d8be211eae307379c13d93c65bc71'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/superlu-5.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/superlu-5.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/superlu-5.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/superlu-5.2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ba7c045b4aefe809e33de9fe35476cca3ed62af1e38ec162c5e199d36d8181e1',
     armv7l: 'ba7c045b4aefe809e33de9fe35476cca3ed62af1e38ec162c5e199d36d8181e1',
       i686: '5f72a5326b985427af744b7de4d379141bb71acf3a0611726ff14fc8832019b5',
     x86_64: '349e683c9d47ecd626543ed10fd2a76561eeb122ecfff7e45d67798db53c5d2c',
  })

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DCMAKE_INSTALL_LIBDIR=#{ARCH_LIB}",
             '-DCMAKE_BUILD_TYPE=Release',
             '-DBUILD_SHARED_LIBS=ON',
             '..'
      system 'make'
    end
  end

  def self.check
    Dir.chdir 'build' do
      system 'make', 'test'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end

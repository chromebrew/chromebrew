require 'package'

class Snappy < Package
  description 'Snappy, a fast compressor/decompressor.'
  homepage 'https://github.com/google/snappy'
  version '1.1.7'
  source_url 'https://github.com/google/snappy/archive/1.1.7.tar.gz'
  source_sha256 '3dfa02e873ff51a11ee02b9ca391807f0c8ea0529a4924afa645fbf97163f9d4'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    FileUtils.mkdir 'build'
    FileUtils.cd('build') do
      system "cmake .. -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
                       -DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX} \
                       -DBUILD_SHARED_LIBS=ON \
                       -DSNAPPY_BUILD_TESTS=OFF" # Tests don't work on ARM
      system 'make'
    end
  end

  def self.install
    system "make -C build DESTDIR=#{CREW_DEST_DIR} install"
  end
end

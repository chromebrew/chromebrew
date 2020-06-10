require 'package'

class Snappy < Package
  description 'Snappy, a fast compressor/decompressor.'
  homepage 'https://github.com/google/snappy'
  version '1.1.7'
  compatibility 'all'
  source_url 'https://github.com/google/snappy/archive/1.1.7.tar.gz'
  source_sha256 '3dfa02e873ff51a11ee02b9ca391807f0c8ea0529a4924afa645fbf97163f9d4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/snappy-1.1.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/snappy-1.1.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/snappy-1.1.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/snappy-1.1.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3ea4b27d211d42908d27ab51d5c35ad3ed4fc19300a6714040e3b2f97e9d106a',
     armv7l: '3ea4b27d211d42908d27ab51d5c35ad3ed4fc19300a6714040e3b2f97e9d106a',
       i686: '98d7365e20a8f9f20a93697ea99955dd8a2e1f2411e314dd0d86f51a0e07a391',
     x86_64: '45695bc3b76470fb98ca385eb7cf0fcb9e08f79492474ea65ee690c4b4ed5474',
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

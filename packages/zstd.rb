require 'package'

class Zstd < Package
  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'http://www.zstd.net'
  @_ver = '1.5.0'
  version "#{@_ver}-1"
  license 'BSD or GPL-2'
  compatibility 'all'
  source_url "https://github.com/facebook/zstd/archive/v#{@_ver}.tar.gz"
  source_sha256 '0d9ade222c64e912d6957b11c923e214e2e010a18f39bec102f572e693ba2867'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.0-1_armv7l/zstd-1.5.0-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.0-1_armv7l/zstd-1.5.0-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.0-1_i686/zstd-1.5.0-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.0-1_x86_64/zstd-1.5.0-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e63e459052fb415caa074ac053bb35418421b2573abf4fad4dd8f94197715187',
     armv7l: 'e63e459052fb415caa074ac053bb35418421b2573abf4fad4dd8f94197715187',
       i686: 'a5260b4a7c9a372571f0d77fc942b3f9f49d16432ed27447f46919cca246c0e2',
     x86_64: 'af4b54526d9a6cd8b35d07b7e12c257cb46a5042861b83cf4248b63b6a6628eb'
  })

  def self.build
    Dir.chdir 'build/cmake' do
      FileUtils.mkdir('builddir')
      Dir.chdir('builddir') do
        system "cmake #{CREW_CMAKE_OPTIONS} \
        -DZSTD_BUILD_STATIC=ON \
        -DZSTD_BUILD_SHARED=ON \
        -DZSTD_LEGACY_SUPPORT=ON \
        -DZSTD_BUILD_CONTRIB=ON \
        ../ -G Ninja"
      end
      system 'ninja -C builddir'
    end
  end

  def self.install
    Dir.chdir 'build/cmake' do
      system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    end
  end
end

require 'package'

class Zstd < Package
  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'http://www.zstd.net'
  @_ver = '1.5.1'
  version @_ver
  license 'BSD or GPL-2'
  compatibility 'all'
  source_url 'https://github.com/facebook/zstd.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.1_armv7l/zstd-1.5.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.1_armv7l/zstd-1.5.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.1_i686/zstd-1.5.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.1_x86_64/zstd-1.5.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '65798a76e98605c8dc68c646fafed3df6bab54cff68efd14f0bdfff847f1212a',
     armv7l: '65798a76e98605c8dc68c646fafed3df6bab54cff68efd14f0bdfff847f1212a',
       i686: '33c872308e4766f78c7cd038822c3e70950cf6051b68f18e574948fe19439f04',
     x86_64: 'bbfd450202fba5e1eaf3b190086ceb9f2eccdb8691cb93387de2467aabd9898b'
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

require 'package'

class Zstd < Package
  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'http://www.zstd.net'
  @_ver = '1.5.4'
  version @_ver
  license 'BSD or GPL-2'
  compatibility 'all'
  source_url 'https://github.com/facebook/zstd.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.4_armv7l/zstd-1.5.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.4_armv7l/zstd-1.5.4-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.4_i686/zstd-1.5.4-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zstd/1.5.4_x86_64/zstd-1.5.4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '85cdfe9c3242874f74cdbc31ed8d07a33d1d9e0fc593317e88d36e2b1f1524e1',
     armv7l: '85cdfe9c3242874f74cdbc31ed8d07a33d1d9e0fc593317e88d36e2b1f1524e1',
       i686: '077b2e269304567c0a413bc636b789130d3f549ec9272b4040b89ee81231482a',
     x86_64: 'd3aab25ec7be12f784474f288ebc6818051f8beb5cddf8580e1d5a35ca0b7e4f'
  })

  depends_on 'glibc' # R
  depends_on 'gcc' # R

  no_patchelf
  no_zstd

  def self.build
    Dir.chdir 'build/cmake' do
      system "cmake -B builddir #{CREW_CMAKE_OPTIONS} \
      -DZSTD_BUILD_STATIC=ON \
      -DZSTD_BUILD_SHARED=ON \
      -DZSTD_LEGACY_SUPPORT=ON \
      -DZSTD_BUILD_CONTRIB=ON \
      -DZSTD_PROGRAMS_LINK_SHARED=OFF \
      -G Ninja"
      system 'samu -C builddir'
    end
  end

  def self.install
    Dir.chdir 'build/cmake' do
      system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
    end
    # Convert symlinks to hard links in libdir.
    Dir.chdir CREW_DEST_LIB_PREFIX do
      Dir['*'].each do |f|
        FileUtils.ln File.realpath(f), f, force: true if File.symlink?(f)
      end
    end
  end
end

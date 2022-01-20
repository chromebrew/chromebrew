require 'package'

class Musl_zstd < Package
  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'http://www.zstd.net'
  @_ver = '1.5.1'
  version @_ver
  license 'BSD or GPL-2'
  compatibility 'all'
  source_url 'https://github.com/facebook/zstd.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_zstd/1.5.1_armv7l/musl_zstd-1.5.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_zstd/1.5.1_armv7l/musl_zstd-1.5.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_zstd/1.5.1_i686/musl_zstd-1.5.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_zstd/1.5.1_x86_64/musl_zstd-1.5.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd87582aa6dbd85e81c90317acd30b30b6300e4c63c01fe5570b37b631338e26e',
     armv7l: 'd87582aa6dbd85e81c90317acd30b30b6300e4c63c01fe5570b37b631338e26e',
       i686: '88af0514d1a2a6d93df12c0566a675175012ed7906b8bb27e7bf50d4d1ec13ae',
     x86_64: 'bd7ef06d006489657649d1e3a2d999dde9b4e2d7788ca9b6b967a7ccecc75b9c'
  })

  depends_on 'musl_native_toolchain' => :build

  is_static

  def self.build
    load "#{CREW_LIB_PATH}lib/musl.rb"
    FileUtils.mkdir('build/cmake/builddir')
    Dir.chdir('build/cmake/builddir') do
      system "#{MUSL_CMAKE_OPTIONS.gsub('-DCMAKE_INTERPROCEDURAL_OPTIMIZATION=TRUE',
                                        '-DCMAKE_INTERPROCEDURAL_OPTIMIZATION=OFF')} \
      -DZSTD_BUILD_STATIC=ON \
      -DZSTD_BUILD_SHARED=OFF \
      -DZSTD_BUILD_PROGRAMS=OFF \
      ../ -G Ninja"
    end
    system "PATH=#{CREW_MUSL_PREFIX}/bin:#{CREW_MUSL_PREFIX}/#{ARCH}-linux-musl#{@abi}/bin:#{ENV['PATH']} \
      samu -C build/cmake/builddir -j#{CREW_NPROC}"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C build/cmake/builddir install"
  end
end

require 'package'

class Musl_zstd < Package
  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'http://www.zstd.net'
  @_ver = '1.5.2'
  version @_ver
  license 'BSD or GPL-2'
  compatibility 'all'
  source_url 'https://github.com/facebook/zstd.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_zstd/1.5.2_armv7l/musl_zstd-1.5.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_zstd/1.5.2_armv7l/musl_zstd-1.5.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_zstd/1.5.2_i686/musl_zstd-1.5.2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_zstd/1.5.2_x86_64/musl_zstd-1.5.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '3cef255a8af0fa12e19e7d91f9b14e4d3c57fd73415f651d5dfc1d78a2d573a9',
     armv7l: '3cef255a8af0fa12e19e7d91f9b14e4d3c57fd73415f651d5dfc1d78a2d573a9',
       i686: '3f0adecdbc55e1c2114ff1013d21da3c11c468a28e5a28dfb54620ba54ea4f36',
     x86_64: '5a96064ca69ee5db65b6961f795a239f83ac5cbca16acea2b59a6f7472d54eb3'
  })

  depends_on 'musl_native_toolchain' => :build

  is_static
  is_musl
  no_zstd
  patchelf
  conflicts_ok # copies in libc.so from musl

  def self.build
    FileUtils.mkdir('build/cmake/builddir')
    Dir.chdir('build/cmake/builddir') do
      system "#{MUSL_CMAKE_OPTIONS.gsub('-DCMAKE_INTERPROCEDURAL_OPTIMIZATION=TRUE',
                                        '-DCMAKE_INTERPROCEDURAL_OPTIMIZATION=OFF')} \
      -DZSTD_BUILD_STATIC=ON \
      -DZSTD_BUILD_SHARED=OFF \
      -DZSTD_BUILD_PROGRAMS=ON \
      -DZSTD_PROGRAMS_LINK_SHARED=OFF \
      -DPROGRAMS_ZSTD_LINK_TARGET=libzstd_static \
      ../ -G Ninja"
    end
    system "#{MUSL_ENV_OPTIONS} \
      samu -C build/cmake/builddir -j#{CREW_NPROC}"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C build/cmake/builddir install"
    FileUtils.mkdir_p "#{CREW_DEST_MUSL_PREFIX}/lib"
    FileUtils.cp "#{CREW_MUSL_PREFIX}/lib/libc.so", "#{CREW_DEST_MUSL_PREFIX}/lib/"
    FileUtils.rm_f Dir.glob("#{CREW_DEST_MUSL_PREFIX}/share/man/")
  end
end

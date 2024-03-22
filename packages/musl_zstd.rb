require 'package'

class Musl_zstd < Package
  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'http://www.zstd.net'
  version '1.5.4'
  license 'BSD or GPL-2'
  compatibility 'all'
  source_url 'https://github.com/facebook/zstd.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'cc967734abc1d7a5bcd5d98145c320f503681e4e61a8778bc3c10cb398b3ddde',
     armv7l: 'cc967734abc1d7a5bcd5d98145c320f503681e4e61a8778bc3c10cb398b3ddde',
       i686: 'd2f19e7f400ee1837bae1274eb194cda2bcfa21bd15865fd29ac8f780d0334bb',
     x86_64: '0b0fe1d9610000330402df3863897a21afb45e42f23a222e21de1b19ea76c6b3'
  })

  depends_on 'musl_native_toolchain' => :build

  conflicts_ok # copies in libc.so from musl
  is_musl
  no_zstd
  patchelf

  def self.build
    FileUtils.mkdir('build/cmake/builddir')
    Dir.chdir('build/cmake/builddir') do
      system "#{MUSL_CMAKE_OPTIONS.gsub('-DCMAKE_INTERPROCEDURAL_OPTIMIZATION=TRUE',
                                        '-DCMAKE_INTERPROCEDURAL_OPTIMIZATION=OFF')} \
      -DZSTD_BUILD_STATIC=ON \
      -DZSTD_BUILD_SHARED=ON \
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

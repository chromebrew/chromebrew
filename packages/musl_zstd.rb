require 'package'

class Musl_zstd < Package
  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'http://www.zstd.net'
  @_ver = '1.5.2'
  version "#{@_ver}-2"
  license 'BSD or GPL-2'
  compatibility 'all'
  source_url 'https://github.com/facebook/zstd.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_zstd/1.5.2-2_armv7l/musl_zstd-1.5.2-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_zstd/1.5.2-2_armv7l/musl_zstd-1.5.2-2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_zstd/1.5.2-2_i686/musl_zstd-1.5.2-2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_zstd/1.5.2-2_x86_64/musl_zstd-1.5.2-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'fc17f3e5f3456deed345eced630e6c7836e81525a494c365bc54277ad6ee0d77',
     armv7l: 'fc17f3e5f3456deed345eced630e6c7836e81525a494c365bc54277ad6ee0d77',
       i686: '6c695a6fe0933b98f4b6bde67af84017975894fcd476318fc9b53f6f7006fb30',
     x86_64: '57510ec4dd8dd6846d11c6d426023fea918399dda184b748d9b508dd10f76696'
  })

  depends_on 'musl_native_toolchain' => :build

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

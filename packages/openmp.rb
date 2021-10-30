# Adapted from Arch Linux openmp PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/openmp/trunk/PKGBUILD

require 'package'

class Openmp < Package
  description 'LLVM OpenMP Runtime Library'
  homepage 'https://openmp.llvm.org/'
  version '13.0.0'
  compatibility 'all'
  source_url "https://github.com/llvm/llvm-project/releases/download/llvmorg-#{version}/openmp-#{version}.src.tar.xz"
  source_sha256 '4930ae7a1829a53b698255c2c6b6ee977cc364b37450c14ee458793c0d5e493c'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/13.0.0_armv7l/openmp-13.0.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/13.0.0_armv7l/openmp-13.0.0-chromeos-armv7l.tpxz',
  })
  binary_sha256 ({
    aarch64: '591d7fa5500ee74e4c1c6fe89abe6bfcbd5c335ec83859388e2a31d3b39fa9cf',
     armv7l: '591d7fa5500ee74e4c1c6fe89abe6bfcbd5c335ec83859388e2a31d3b39fa9cf',
  })

  depends_on 'libffi'
  depends_on 'llvm' => ':build'

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env LLVM_IAS=1 LD=ld.lld \
            cmake -G Ninja \
            -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
            -DCMAKE_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
            -DCMAKE_BUILD_TYPE=Release \
            -DCMAKE_C_COMPILER=$(which clang) \
            -DCMAKE_C_COMPILER_TARGET=#{CREW_BUILD} \
            -DCMAKE_CXX_COMPILER=$(which clang++) \
            -DCMAKE_C_FLAGS='-fuse-ld=lld' \
            -DCMAKE_CXX_FLAGS='-fuse-ld=lld' \
            -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
            -DCMAKE_LINKER=$(which ld.lld) \
            -D_CMAKE_TOOLCHAIN_PREFIX=llvm- \
            -DLIBOMP_ENABLE_SHARED=ON \
            -DLIBOMP_INSTALL_ALIASES=OFF \
            -DLLVM_LIBDIR_SUFFIX='#{CREW_LIB_SUFFIX}' \
            -DPYTHON_EXECUTABLE=$(which python3) \
            -Wno-dev \
            .."
      system 'ninja'
    end
  end

  def self.install
    Dir.chdir('builddir') do
      system "DESTDIR=#{CREW_DEST_DIR} ninja install"
    end
  end
end

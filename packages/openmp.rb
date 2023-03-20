# Adapted from Arch Linux openmp PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/openmp/trunk/PKGBUILD

require 'package'

class Openmp < Package
  description 'LLVM OpenMP Runtime Library'
  homepage 'https://openmp.llvm.org/'
  @_ver = '16.0.0'
  version @_ver
  # When upgrading llvm, be sure to upgrade openmp in tandem.
  # puts "#{self} version differs from llvm version #{Llvm.version}".orange if @_ver != Llvm.version
  license 'Apache-2.0-with-LLVM-exceptions, UoI-NCSA, BSD, public-domain, rc, Apache-2.0 and MIT'
  compatibility 'all'
  source_url 'https://github.com/llvm/llvm-project.git'
  git_hashtag "llvmorg-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/16.0.0_armv7l/openmp-16.0.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/16.0.0_armv7l/openmp-16.0.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/16.0.0_i686/openmp-16.0.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/16.0.0_x86_64/openmp-16.0.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'cb37a3f3cfef71ea12fbfa5dad4fdbbb1d0114ec1275e0663c279bebeb3c15f9',
     armv7l: 'cb37a3f3cfef71ea12fbfa5dad4fdbbb1d0114ec1275e0663c279bebeb3c15f9',
       i686: 'cbb25f7995845f3eaba1e5319cd17ad90479d9f22a1149c67e0569145415546b',
     x86_64: 'b23686a61918763b562dce811c096cd2f54b2f719ee132b7a1a1245cc74beea8'
  })

  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'libffi'
  depends_on 'llvm' # R
  depends_on 'python3' # R

  no_env_options

  def self.build
    Dir.mkdir 'openmp/builddir'
    Dir.chdir 'openmp/builddir' do
      system "cmake -G Ninja \
            #{CREW_CMAKE_FNO_LTO_OPTIONS.gsub('-fno-lto', '').gsub('-ffat-lto-objects', '')} \
            -DCMAKE_C_COMPILER=$(which clang) \
            -DCMAKE_C_COMPILER_TARGET=#{CREW_BUILD} \
            -DCMAKE_CXX_COMPILER=$(which clang++) \
            -DCMAKE_CXX_COMPILER_AR=$(which llvm-ar) \
            -DCMAKE_CXX_COMPILER_RANLIB=$(which llvm-ranlib) \
            -D_CMAKE_TOOLCHAIN_PREFIX=llvm- \
            -DLIBOMP_ENABLE_SHARED=ON \
            -DLIBOMP_INSTALL_ALIASES=OFF \
            -DOPENMP_LIBDIR_SUFFIX=#{CREW_LIB_SUFFIX} \
            -DPYTHON_EXECUTABLE=$(which python3) \
            -DLLVM_INCLUDE_BENCHMARKS=OFF \
            -Wno-dev \
            .."
      system 'mold -run ninja'
    end
  end

  def self.install
    Dir.chdir('openmp/builddir') do
      system "DESTDIR=#{CREW_DEST_DIR} ninja install"
    end
  end
end

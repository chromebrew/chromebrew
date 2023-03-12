# Adapted from Arch Linux openmp PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/openmp/trunk/PKGBUILD

require 'package'

class Openmp < Package
  description 'LLVM OpenMP Runtime Library'
  homepage 'https://openmp.llvm.org/'
  @_ver = '16.0.0-rc4'
  version @_ver
  # When upgrading llvm, be sure to upgrade openmp in tandem.
  # puts "#{self} version differs from llvm version #{Llvm.version}".orange if @_ver != Llvm.version
  license 'Apache-2.0-with-LLVM-exceptions, UoI-NCSA, BSD, public-domain, rc, Apache-2.0 and MIT'
  compatibility 'all'
  source_url 'https://github.com/llvm/llvm-project.git'
  git_hashtag "llvmorg-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/16.0.0-rc4_armv7l/openmp-16.0.0-rc4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/16.0.0-rc4_armv7l/openmp-16.0.0-rc4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/16.0.0-rc4_i686/openmp-16.0.0-rc4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/16.0.0-rc4_x86_64/openmp-16.0.0-rc4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '351304a3a28627e3ad34664faf03e8453c985c4dc94a094ed889c8423df25770',
     armv7l: '351304a3a28627e3ad34664faf03e8453c985c4dc94a094ed889c8423df25770',
       i686: 'ad33687f8f1b7e8704ded3c39ced2bdaa550d82ce1553fb3942612a989faa413',
     x86_64: 'c2fb1058e4be228064a694fb070590cebbb9bfe01168a48e06ebc1ff9ee919c8'
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

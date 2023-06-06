# Adapted from Arch Linux openmp PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/openmp/trunk/PKGBUILD

require 'package'
require_relative 'llvm_build16'

class Openmp < Package
  description 'LLVM OpenMP Runtime Library'
  homepage 'https://openmp.llvm.org/'
  version '16.0.5'
  # When upgrading llvm_build*, be sure to upgrade openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm_build16.version}".orange if version != Llvm_build16.version.to_s
  license 'Apache-2.0-with-LLVM-exceptions, UoI-NCSA, BSD, public-domain, rc, Apache-2.0 and MIT'
  compatibility 'all'
  source_url 'https://github.com/llvm/llvm-project.git'
  git_hashtag Llvm_build16.git_hashtag.to_s

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/16.0.5_armv7l/openmp-16.0.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/16.0.5_armv7l/openmp-16.0.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/16.0.5_i686/openmp-16.0.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/16.0.5_x86_64/openmp-16.0.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd667cec638ae62c4dc55e11f806948aca950bd365700cf8154e446fc843ed597',
     armv7l: 'd667cec638ae62c4dc55e11f806948aca950bd365700cf8154e446fc843ed597',
       i686: '0b88daf871a13bf1eab3216ecce5e13e881e69aea6d96296c1d08dd2fe08fc87',
     x86_64: '99e5bec3bb7c1704c1002c7abdb9dc3764a8cae950229bf589f475163f23e905'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libffi'
  depends_on 'llvm_lib16' # R
  depends_on 'python3' # R

  no_env_options

  def self.build
    system "cmake -B builddir -G Ninja openmp \
      #{CREW_CMAKE_FNO_LTO_OPTIONS.gsub('-fno-lto', '').gsub('-ffat-lto-objects', '')} \
      -DCMAKE_C_COMPILER=$(which clang) \
      -DCMAKE_C_COMPILER_TARGET=#{CREW_BUILD} \
      -DCMAKE_CXX_COMPILER=$(which clang++) \
      -DCMAKE_CXX_COMPILER_AR=$(which llvm-ar) \
      -DCMAKE_CXX_COMPILER_RANLIB=$(which llvm-ranlib) \
      -D_CMAKE_TOOLCHAIN_PREFIX=llvm- \
      -DLIBOMP_ENABLE_SHARED=ON \
      -DLIBOMP_INSTALL_ALIASES=OFF \
      -DLLVM_INCLUDE_BENCHMARKS=OFF \
      -DOPENMP_LIBDIR_SUFFIX=#{CREW_LIB_SUFFIX} \
      -DPYTHON_EXECUTABLE=$(which python3) \
      -Wno-dev"
    system "mold -run #{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end

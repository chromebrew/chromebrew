# Adapted from Arch Linux openmp PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/openmp/trunk/PKGBUILD

require 'package'
require_relative 'llvm'

class Openmp < Package
  description 'LLVM OpenMP Runtime Library'
  homepage 'https://openmp.llvm.org/'
  version '16.0.2'
  # When upgrading llvm, be sure to upgrade openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm.version}".orange if version != Llvm.version.to_s
  license 'Apache-2.0-with-LLVM-exceptions, UoI-NCSA, BSD, public-domain, rc, Apache-2.0 and MIT'
  compatibility 'all'
  source_url 'https://github.com/llvm/llvm-project.git'
  git_hashtag Llvm.git_hashtag.to_s

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/16.0.2_armv7l/openmp-16.0.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/16.0.2_armv7l/openmp-16.0.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/16.0.2_i686/openmp-16.0.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/16.0.2_x86_64/openmp-16.0.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '28739cf683e833c37f58769ae6c359f71ea0eecf3a65909905dbcf656ea165d0',
     armv7l: '28739cf683e833c37f58769ae6c359f71ea0eecf3a65909905dbcf656ea165d0',
       i686: 'adc86ccc6fdd402c3873c0d18d5f6e98cc5edf6dae3a8310f1e869ce1008b54f',
     x86_64: '461ed783e5b255513b41ab1be7899617189f1c96bad78f69a0fccd19c75145f7'
  })

  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'libffi'
  depends_on 'llvm' # R
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

# Adapted from Arch Linux openmp PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/openmp/trunk/PKGBUILD

require 'package'
require_relative 'llvm17_build'

class Openmp < Package
  description 'LLVM OpenMP Runtime Library'
  homepage 'https://openmp.llvm.org/'
  version '17.0.3'
  # When upgrading llvm_build*, be sure to upgrade openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm17_build.version}".orange if version != Llvm17_build.version.to_s
  license 'Apache-2.0-with-LLVM-exceptions, UoI-NCSA, BSD, public-domain, rc, Apache-2.0 and MIT'
  compatibility 'all'
  source_url 'https://github.com/llvm/llvm-project.git'
  git_hashtag Llvm17_build.git_hashtag.to_s

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/17.0.3_armv7l/openmp-17.0.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/17.0.3_armv7l/openmp-17.0.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/17.0.3_i686/openmp-17.0.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/17.0.3_x86_64/openmp-17.0.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b8768518be054eb550bb49eb4ecad131d7b5b3d6d19db4a62c52ac5fae48709e',
     armv7l: 'b8768518be054eb550bb49eb4ecad131d7b5b3d6d19db4a62c52ac5fae48709e',
       i686: 'd432c11f8cb653b805658eb3d3809f2e7b9dce40d7f2d94c13ceb3c9df796f6e',
     x86_64: '664e6705fdeb851c2ee8039ab334410aed6c9a275a93c1da344fda1ebc88d9f0'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libffi'
  depends_on 'llvm17_dev' => :build
  depends_on 'llvm17_lib' # R
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

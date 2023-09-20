# Adapted from Arch Linux openmp PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/openmp/trunk/PKGBUILD

require 'package'
require_relative 'llvm17_build'

class Openmp < Package
  description 'LLVM OpenMP Runtime Library'
  homepage 'https://openmp.llvm.org/'
  version '17.0.1'
  # When upgrading llvm_build*, be sure to upgrade openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm17_build.version}".orange if version != Llvm17_build.version.to_s
  license 'Apache-2.0-with-LLVM-exceptions, UoI-NCSA, BSD, public-domain, rc, Apache-2.0 and MIT'
  compatibility 'all'
  source_url 'https://github.com/llvm/llvm-project.git'
  git_hashtag Llvm17_build.git_hashtag.to_s

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/17.0.1_armv7l/openmp-17.0.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/17.0.1_armv7l/openmp-17.0.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/17.0.1_i686/openmp-17.0.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openmp/17.0.1_x86_64/openmp-17.0.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e0aa30454ffd6ba69e171dadbdb5109d8eccd3df4022135797cbdcd09ce8a5fe',
     armv7l: 'e0aa30454ffd6ba69e171dadbdb5109d8eccd3df4022135797cbdcd09ce8a5fe',
       i686: '1bd221ab4fa22f820b8e55f1c1937f822cab51e31c16059ad1ad4555d222d67c',
     x86_64: '61a9f7aa4d62cf3ee7ebd089ce2a01b02609af1dcea68570e748224eb8b6f563'
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

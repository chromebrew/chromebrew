# Adapted from Arch Linux openmp PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/openmp/trunk/PKGBUILD

require 'package'
require_relative 'llvm18_build'

class Openmp < Package
  description 'LLVM OpenMP Runtime Library'
  homepage 'https://openmp.llvm.org/'
  version '18.1.0'
  # When upgrading llvm_build*, be sure to upgrade openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm18_build.version}".orange if version != Llvm18_build.version
  license 'Apache-2.0-with-LLVM-exceptions, UoI-NCSA, BSD, public-domain, rc, Apache-2.0 and MIT'
  compatibility 'all'
  source_url 'https://github.com/llvm/llvm-project.git'
  git_hashtag Llvm18_build.git_hashtag.to_s
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8062c69c3bc0e54db68ebdf019e9e2f192d6eda130710e67fc751edfcae13feb',
     armv7l: '8062c69c3bc0e54db68ebdf019e9e2f192d6eda130710e67fc751edfcae13feb',
       i686: '9ef0a14a9fbc76ffc4b7598b7bc8e2ea63df0c35634e31a6e52f8476598987f9',
     x86_64: 'a4cf64ad9ec2738d0afdb55ca14cf904623d34bf116a3ebeaa4a24b2e2aa1503'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'llvm18_dev' => :build
  depends_on 'llvm18_lib' # R
  depends_on 'python3' # R

  no_env_options

  def self.patch
    # This patch should be in 18.0.1.
    downloader 'https://github.com/llvm/llvm-project/commit/bb22eccc90d0e8cb02be5d4c47a08a17baf4d242.patch', '3a97108033890957acf0cce214a6366b77b61caf5a4aa5a5e75d384da7f2dde1'
    system 'patch -F3 -p1 -i bb22eccc90d0e8cb02be5d4c47a08a17baf4d242.patch'

    # llvm 18.x backport.
    downloader 'https://github.com/llvm/llvm-project/pull/84290.patch', 'a54bedaa078a2bf1778e66195e016f6794a431e8622a45ee7a49bc0ca898b82b'
    system 'patch -F3 -p1 -i 84290.patch'

    # Remove rc suffix on final release.
    system "sed -i 's,set(LLVM_VERSION_SUFFIX rc),,' llvm/CMakeLists.txt"
  end

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

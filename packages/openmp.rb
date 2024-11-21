# Adapted from Arch Linux openmp PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/openmp/trunk/PKGBUILD

require 'package'
Package.load_package("#{__dir__}/llvm19_build.rb")

class Openmp < Package
  description 'LLVM OpenMP Runtime Library'
  homepage 'https://openmp.llvm.org/'
  version '19.1.4'
  # When upgrading llvm_build*, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm19_build.version}".orange if version != Llvm19_build.version
  license 'Apache-2.0-with-LLVM-exceptions, UoI-NCSA, BSD, public-domain, rc, Apache-2.0 and MIT'
  compatibility 'all'
  source_url 'https://github.com/llvm/llvm-project.git'
  git_hashtag Llvm19_build.git_hashtag.to_s
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4ed53803d01926e54c23497b9fe7ff09068184b834b006c8024c5a2c14d3661d',
     armv7l: '4ed53803d01926e54c23497b9fe7ff09068184b834b006c8024c5a2c14d3661d',
       i686: '56496ab40d0d1bc6915088cd1cd4e7b018828b0cce507ef59751187c66f494a7',
     x86_64: '9c28f6bbc4b86c1b515e5d1828182a5e78beb2c9ff779192ef4423c1b773a6d3'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'llvm19_dev' => :build
  depends_on 'llvm19_lib' # R
  depends_on 'python3' # R

  no_env_options

  def self.patch
    # Remove rc suffix on final release.
    system "sed -i 's,set(LLVM_VERSION_SUFFIX rc),,' llvm/CMakeLists.txt"

    # Patch for LLVM 15+ because of https://github.com/llvm/llvm-project/issues/58851
    File.write 'llvm_crew_lib_prefix.patch', <<~LLVM_PATCH_EOF
      --- a/clang/lib/Driver/ToolChains/Linux.cpp	2022-11-30 15:50:36.777754608 -0500
      +++ b/clang/lib/Driver/ToolChains/Linux.cpp	2022-11-30 15:51:57.004417484 -0500
      @@ -314,6 +314,7 @@ Linux::Linux(const Driver &D, const llvm
             D.getVFS().exists(D.Dir + "/../lib/libc++.so"))
           addPathIfExists(D, D.Dir + "/../lib", Paths);

      +  addPathIfExists(D, concat(SysRoot, "#{CREW_LIB_PREFIX}"), Paths);
         addPathIfExists(D, concat(SysRoot, "/lib"), Paths);
         addPathIfExists(D, concat(SysRoot, "/usr/lib"), Paths);
       }
    LLVM_PATCH_EOF
    system 'patch -Np1 -i llvm_crew_lib_prefix.patch'
  end

  def self.build
    @cmake_options = case ARCH
                     when 'i686', 'x86_64'
                       CREW_CMAKE_FNO_LTO_OPTIONS.gsub('-fno-lto', '')
                     else
                       CREW_CMAKE_OPTIONS
                     end
    system "cmake -B builddir -G Ninja openmp \
      #{@cmake_options} \
      -DCLANG_DEFAULT_LINKER=#{CREW_LINKER} \
      -DCMAKE_C_COMPILER=$(which clang) \
      -DCMAKE_C_COMPILER_TARGET=#{CREW_TARGET} \
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

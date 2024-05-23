# Adapted from Arch Linux libclc PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libclc/trunk/PKGBUILD

require 'package'
require_relative 'llvm18_build'

class Libclc < Package
  description 'Library requirements of the OpenCL C programming language'
  homepage 'https://libclc.llvm.org/'
  version '18.1.6'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm18_build.version}".orange if version != Llvm18_build.version
  license 'Apache-2.0-with-LLVM-exceptions, UoI-NCSA, BSD, public-domain, rc, Apache-2.0 and MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/llvm/llvm-project.git'
  git_hashtag Llvm18_build.git_hashtag.to_s
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b7bb07e22b678fcb9beea584fc96fbb678ded81511cd0ec9effeff164853eb1f',
     armv7l: 'b7bb07e22b678fcb9beea584fc96fbb678ded81511cd0ec9effeff164853eb1f',
     x86_64: '83327f04fb235241f9f1a016fa16f47ffef8f5d38da480ac454ddbe1658ca11c'
  })

  depends_on 'llvm18_dev' => :build
  depends_on 'python3' => :build
  depends_on 'spirv_llvm_translator' => :build

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
    system "cmake -B builddir -G Ninja libclc \
      #{@cmake_options.gsub('-DCMAKE_LINKER_TYPE=MOLD', '')} \
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
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end

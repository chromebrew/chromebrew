# Adapted from Arch Linux libclc PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libclc/trunk/PKGBUILD

require 'package'
Package.load_package("#{__dir__}/llvm19_build.rb")

class Libclc < Package
  description 'Library requirements of the OpenCL C programming language'
  homepage 'https://libclc.llvm.org/'
  version '19.1.4'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{Llvm19_build.version}".orange if version != Llvm19_build.version
  license 'Apache-2.0-with-LLVM-exceptions, UoI-NCSA, BSD, public-domain, rc, Apache-2.0 and MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/llvm/llvm-project.git'
  git_hashtag Llvm19_build.git_hashtag.to_s
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5dad3e67079bc62721e86ab0c0d5e6f12b9efb3bf15f43f40f17e85ce2fd33f8',
     armv7l: '5dad3e67079bc62721e86ab0c0d5e6f12b9efb3bf15f43f40f17e85ce2fd33f8',
     x86_64: '37c28e0d86c42702e00a2d5f95dfbbb11203d003b2af42a6f25c9ed7139ed001'
  })

  depends_on 'llvm19_dev' => :build
  depends_on 'python3' => :build
  depends_on 'sccache' => :build
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
      -DCLANG_DEFAULT_LINKER=#{CREW_LINKER} \
      -DCMAKE_C_COMPILER=$(which clang) \
      -DCMAKE_C_COMPILER_LAUNCHER=sccache \
      -DCMAKE_C_COMPILER_TARGET=#{CREW_TARGET} \
      -DCMAKE_CXX_COMPILER=$(which clang++) \
      -DCMAKE_CXX_COMPILER_LAUNCHER=sccache \
      -DCMAKE_CXX_COMPILER_AR=$(which llvm-ar) \
      -DCMAKE_CXX_COMPILER_RANLIB=$(which llvm-ranlib) \
      -D_CMAKE_TOOLCHAIN_PREFIX=llvm- \
      -Wno-dev"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end

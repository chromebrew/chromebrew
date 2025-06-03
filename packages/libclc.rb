# Adapted from Arch Linux libclc PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libclc/trunk/PKGBUILD

require 'package'

class Libclc < Package
  llvm_build_obj = Package.load_package("#{__dir__}/#{CREW_LLVM_VER}_build.rb")
  description 'Library requirements of the OpenCL C programming language'
  homepage 'https://libclc.llvm.org/'
  version '20.1.6'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  puts "#{self} version differs from llvm version #{llvm_build_obj.version}".orange if version != llvm_build_obj.version
  license 'Apache-2.0-with-LLVM-exceptions, UoI-NCSA, BSD, public-domain, rc, Apache-2.0 and MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/llvm/llvm-project.git'
  git_hashtag llvm_build_obj.git_hashtag.to_s
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ecb12c840d428bd053bff8fbc4a2e6ddaad95bbfe86ba818dad4580f7783efee',
     armv7l: 'ecb12c840d428bd053bff8fbc4a2e6ddaad95bbfe86ba818dad4580f7783efee',
     x86_64: '07d29f70b74c4ac139fd80ec9c19aa97f2c1aa9328ed25d9d85a40a381c9ff0b'
  })

  depends_on 'llvm_dev' => :build
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
                       CREW_CMAKE_OPTIONS.gsub('-flto=auto', '').sub('-DCMAKE_INTERPROCEDURAL_OPTIMIZATION=TRUE', '')
                     else
                       CREW_CMAKE_OPTIONS
                     end
    system "cmake -B builddir -G Ninja libclc \
      #{@cmake_options.gsub('-DCMAKE_LINKER_TYPE=MOLD', '')} \
      -DCMAKE_C_COMPILER=$(which clang) \
      -DCMAKE_C_COMPILER_TARGET=#{CREW_TARGET} \
      -DCMAKE_CXX_COMPILER=$(which clang++) \
      -DCMAKE_CXX_COMPILER_AR=$(which llvm-ar) \
      -DCMAKE_CXX_COMPILER_RANLIB=$(which llvm-ranlib) \
      -DCMAKE_INSTALL_LIBDIR=#{ARCH_LIB} \
      -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
      -DCMAKE_LIBRARY_PATH='#{CREW_GLIBC_INTERPRETER.nil? ? CREW_LIB_PREFIX : "#{CREW_GLIBC_PREFIX};#{CREW_LIB_PREFIX}"}' \
      -D_CMAKE_TOOLCHAIN_PREFIX=llvm- \
      -Wno-dev"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end

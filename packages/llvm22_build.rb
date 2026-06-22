require 'package'

class Llvm22_build < Package
  # Note that compiler-rt cannot be removed from @llvm_projects_to_build
  # due to https://github.com/llvm/llvm-project/issues/141329
  @llvm_projects_to_build = ARCH == 'x86_64' ? 'bolt;clang;clang-tools-extra;lld;lldb;compiler-rt;polly' : 'clang;clang-tools-extra;lld;lldb;compiler-rt;polly'
  description "The LLVM Project is a collection of modular and reusable compiler and toolchain technologies. The packages included are: #{@llvm_projects_to_build.gsub(';', ' ')}"
  homepage 'https://llvm.org/'
  version '22.1.8'
  # When upgrading llvm*_build, be sure to upgrade llvm_lib*, llvm_dev*, libclc, and openmp in tandem.
  license 'Apache-2.0-with-LLVM-exceptions, UoI-NCSA, BSD, public-domain, rc, Apache-2.0 and MIT'
  compatibility 'all'
  source_url "https://github.com/llvm/llvm-project/archive/refs/tags/llvmorg-#{version}.tar.gz"
  source_sha256 'ad18b70e287954c3d62bc7e0b86e7b7af2adf87bcfce21c15fe717f101d7aace'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '224ae5869d21ba0e2a7120fe02a67a84787bc0f7261bf6b47e79e2157a2c5dd2',
     armv7l: '224ae5869d21ba0e2a7120fe02a67a84787bc0f7261bf6b47e79e2157a2c5dd2',
       i686: 'e0e61c466f85b479e76f7f24bc3d202a36314fcbba385776d668b15acdfc2049',
     x86_64: '6bcaafb4790ee9c3ba8c020e1bcfc5d6fe6e796719f8581039e2a7d9786b1770'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'graphviz' => :build
  depends_on 'libedit' => :library
  depends_on 'libffi' => :library
  depends_on 'libxml2' => :library
  depends_on 'llvm_dev' => :build
  depends_on 'ocaml' => :build
  depends_on 'py3_pygments' => :build
  depends_on 'py3_pyyaml' => :build
  depends_on 'xzutils' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  conflicts_ok
  no_env_options

  def self.patch
    # Remove rc suffix on final release.
    system "sed -i 's,set(LLVM_VERSION_SUFFIX rc),,' llvm/CMakeLists.txt"

    # Patch for LLVM 15+ because of https://github.com/llvm/llvm-project/issues/58851
    File.write 'llvm_crew_lib_prefix.patch', <<~LLVM_PATCH_EOF
      --- a/clang/lib/Driver/ToolChains/Linux.cpp       2022-11-30 15:50:36.777754608 -0500
      +++ b/clang/lib/Driver/ToolChains/Linux.cpp       2022-11-30 15:51:57.004417484 -0500
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
    case ARCH
    when 'aarch64', 'armv7l'
      # @llvm_targets_to_build = 'ARM;AArch64;AMDGPU'
      # @llvm_targets_to_build = 'all'.freeze
      @ARCH_C_FLAGS = "-mfloat-abi=hard -mthumb -mfpu=vfpv3-d16 -march=armv7-a+fp -ccc-gcc-name #{CREW_TARGET} -I#{CREW_LIB_PREFIX}/clang/#{`clang -dumpversion`.split('.').first}/include"
      @ARCH_CXX_FLAGS = "-mfloat-abi=hard -mthumb -mfpu=vfpv3-d16 -march=armv7-a+fp -ccc-gcc-name #{CREW_TARGET} -I#{CREW_LIB_PREFIX}/clang/#{`clang -dumpversion`.split('.').first}/include"
      @ARCH_LDFLAGS = ''
    when 'i686'
      # @llvm_targets_to_build = 'X86'.freeze
      # Because ld.lld: error: undefinler-rt;libc;libcxx;libcxxabi;libunwind;openmped symbol: __atomic_store
      # Polly demands fPIC
      @ARCH_C_FLAGS = '-latomic'
      @ARCH_CXX_FLAGS = '-latomic'
      # Because getting this error:
      # ld.lld: error: relocation R_386_PC32 cannot be used against symbol isl_map_fix_si; recompile with -fPIC
      # So as per https://github.com/openssl/openssl/issues/11305#issuecomment-602003528
      @ARCH_LDFLAGS = '-Wl,-znotext'
      # lldb fails on i686 due to requirement for a kernel > 4.1.
      # See https://github.com/llvm/llvm-project/issues/57594
    when 'x86_64'
      # @llvm_targets_to_build = 'X86;AMDGPU'
      # @llvm_targets_to_build = 'all'.freeze
      @ARCH_C_FLAGS = ''
      @ARCH_CXX_FLAGS = ''
      @ARCH_LDFLAGS = ''
    end
    @ARCH_C_LTO_FLAGS = "#{@ARCH_C_FLAGS} -fPIC -flto=thin #{CREW_LINKER_FLAGS}"
    @ARCH_CXX_LTO_FLAGS = "#{@ARCH_CXX_FLAGS} -fPIC -flto=thin #{CREW_LINKER_FLAGS}"
    @ARCH_LTO_LDFLAGS = "#{@ARCH_LDFLAGS} -flto=thin #{CREW_LINKER_FLAGS}"
    # flang isn't supported on 32-bit architectures.
    # openmp is its own package.

    # Using Targets 'all' for non-i686 because otherwise mesa complains.
    # This may be patched upstream as per
    # https://reviews.llvm.org/rG1de56d6d13c083c996dfd44a32041dacae037d66
    @llvm_targets_to_build = 'all'.freeze

    ############################################################
    puts "Building LLVM Targets: #{@llvm_targets_to_build}".lightgreen
    puts "Building LLVM Projects: #{@llvm_projects_to_build}".lightgreen
    ############################################################

    unless Dir.exist?('builddir')
      FileUtils.mkdir_p 'builddir'
      File.write 'builddir/clc', <<~CLC_EOF
        #!/bin/bash
        machine=$(gcc -dumpmachine)
        version=$(gcc -dumpversion)
        gnuc_lib=#{CREW_LIB_PREFIX}/gcc/${machine}/${version}
        clang -B ${gnuc_lib} -L ${gnuc_lib} "$@"
      CLC_EOF
      File.write 'builddir/clc++', <<~CLCPLUSPLUS_EOF
        #!/bin/bash
        machine=$(gcc -dumpmachine)
        version=$(gcc -dumpversion)
        cxx_sys=#{CREW_PREFIX}/include/c++/${version}
        cxx_inc=#{CREW_PREFIX}/include/c++/${version}/${machine}
        gnuc_lib=#{CREW_LIB_PREFIX}/gcc/${machine}/${version}
        clang++ -fPIC -rtlib=compiler-rt -stdlib=libc++ -cxx-isystem ${cxx_sys} -I ${cxx_inc} -B ${gnuc_lib} -L ${gnuc_lib} "$@"
      CLCPLUSPLUS_EOF
      system "cmake -B builddir -G Ninja llvm \
            -DCLANG_DEFAULT_LINKER=mold \
            -DCMAKE_ASM_COMPILER_TARGET=#{CREW_TARGET} \
            -DCMAKE_BUILD_TYPE=Release \
            -DCMAKE_C_COMPILER=$(which clang) \
            -DCMAKE_C_COMPILER_TARGET=#{CREW_TARGET} \
            -DCMAKE_C_FLAGS='#{@ARCH_C_LTO_FLAGS}' \
            -DC_INCLUDE_DIRS='#{CREW_LIB_PREFIX}/clang/#{`clang -dumpversion`.split('.').first}/include' \
            -DCMAKE_CXX_COMPILER=$(which clang++) \
            -DCMAKE_CXX_FLAGS='#{@ARCH_CXX_LTO_FLAGS}' \
            -DCMAKE_EXE_LINKER_FLAGS='#{@ARCH_LTO_LDFLAGS}' \
            -DCMAKE_INSTALL_LIBDIR=#{ARCH_LIB} \
            -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
            -DCMAKE_LIBRARY_PATH='#{CREW_GLIBC_INTERPRETER.nil? ? CREW_LIB_PREFIX : "#{CREW_GLIBC_PREFIX};#{CREW_LIB_PREFIX}"}' \
            -D_CMAKE_TOOLCHAIN_PREFIX=llvm- \
            -DCOMPILER_RT_BUILD_BUILTINS=ON \
            -DCOMPILER_RT_BUILD_LIBFUZZER=OFF \
            -DCOMPILER_RT_BUILD_SANITIZERS=OFF \
            -DCOMPILER_RT_DEFAULT_TARGET_ONLY=ON \
            -DLLDB_INCLUDE_TESTS=OFF \
            -DLLVM_BINUTILS_INCDIR='#{CREW_PREFIX}/include' \
            -DLLVM_BUILD_LLVM_DYLIB=ON \
            -DLLVM_DEFAULT_TARGET_TRIPLE=#{CREW_TARGET} \
            -DLLVM_ENABLE_FFI=ON \
            -DLLVM_ENABLE_LTO=Thin \
            -DLLVM_ENABLE_PIC=ON \
            -DLLVM_ENABLE_PROJECTS='#{@llvm_projects_to_build}' \
            -DLLVM_ENABLE_RTTI=ON \
            -DLLVM_INCLUDE_BENCHMARKS=OFF \
            -DLLVM_INSTALL_UTILS=ON \
            -DLLVM_LIBDIR_SUFFIX='#{CREW_LIB_SUFFIX}' \
            -DLLVM_LINK_LLVM_DYLIB=ON \
            -DLLVM_OPTIMIZED_TABLEGEN=ON \
            -DLLVM_TARGETS_TO_BUILD='#{@llvm_targets_to_build}' \
            -Wno-dev"
    end
    system "#{CREW_NINJA} -C builddir -j #{CREW_NPROC}"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    Dir.chdir('builddir') do
      FileUtils.install 'clc', "#{CREW_DEST_PREFIX}/bin/clc", mode: 0o755
      FileUtils.install 'clc++', "#{CREW_DEST_PREFIX}/bin/clc++", mode: 0o755
      FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/bfd-plugins"
      Dir.chdir("#{CREW_DEST_LIB_PREFIX}/bfd-plugins") do
        FileUtils.ln_s "../../lib#{CREW_LIB_SUFFIX}/LLVMgold.so", 'LLVMgold.so'
      end
      # libunwind.* conflicts with libunwind package
      FileUtils.rm Dir.glob("#{CREW_DEST_LIB_PREFIX}/libunwind.*")
    end
  end

  # preserve for check, skip check for current version
  # def self.check
  #   Dir.chdir('builddir') do
  #     system 'ninja check-llvm || true'
  #     system 'ninja check-clang || true'
  #     system 'ninja check-lld || true'
  #   end
  # end

  def self.postinstall
    puts
    puts "To compile programs, use 'clang' or 'clang++'.".lightblue
    puts
    puts 'To avoid the repeated use of switch options,'.lightblue
    puts "try the wrapper scripts 'clc' or 'clc++'.".lightblue
    puts
    puts 'For more information, see https://llvm.org/pubs/2008-10-04-ACAT-LLVM-Intro.pdf'.lightblue
    puts
  end
end

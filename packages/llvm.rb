require 'package'

class Llvm < Package
  description 'The LLVM Project is a collection of modular and reusable compiler and toolchain technologies. The optional packages clang, lld, lldb, polly, compiler-rt, libcxx, libcxxabi, and openmp are included.'
  homepage 'http://llvm.org/'
  @_ver = '11.1.0'
  version @_ver + '-rc1'
  compatibility 'all'
  source_url "https://github.com/llvm/llvm-project/archive/llvmorg-#{@_ver}.tar.gz"
  source_sha256 'e610297041129a5c5b24355a988c99c7452ee7105ee2355334a8c521b988eb3c'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-11.1.0-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-11.1.0-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-11.1.0-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-11.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '5ecb72e60483b15c7588446a7ac424d64cdd3f21ca0fa5ffea4737a25dedca89',
      armv7l: '5ecb72e60483b15c7588446a7ac424d64cdd3f21ca0fa5ffea4737a25dedca89',
        i686: '5595ca097aa454bd54b8a336d467ee266f8afd4bd8100d1a3831e3face9b4f43',
      x86_64: '031f6f3510ebbc5a1270fac07934d7efa9126c8e89f98695505b1376d6d233a5',
  })
  
  # llvm_stage1 is compiled with gcc, without -flto
  # Then in stage 2 (llvm.rb) everything is compiled with clang built in stage 1, with -flto=thin
  # FYI LLVM 11.1.0 is a tiny rebuild of 11.0.1 fixing ABI compatibility with LLVM 10.0.0 & LLVM 12

  depends_on 'ocaml' => :build
  depends_on 'libedit'
  depends_on 'libtirpc'
  depends_on 'swig'
  depends_on 'pygments' => :build
  depends_on 'ccache' => :build
  depends_on 'llvm_stage1' => :build
  depends_on 'binutils' => :build

  case ARCH
  when 'aarch64','armv7l'
    #LLVM_TARGETS_TO_BUILD = 'ARM;AArch64;AMDGPU'
    LLVM_TARGETS_TO_BUILD = 'all'
    @ARCH_C_FLAGS = "-fPIC -march=armv7-a -mfloat-abi=hard -ccc-gcc-name #{LLVM_DEFAULT_TARGET_TRIPLE}"
    @ARCH_CXX_FLAGS = "-fPIC -march=armv7-a -mfloat-abi=hard -ccc-gcc-name #{LLVM_DEFAULT_TARGET_TRIPLE}"
    @ARCH_LDFLAGS=''
  when 'i686'
    LLVM_TARGETS_TO_BUILD = 'X86'
    # Because ld.lld: error: undefined symbol: __atomic_store
    # Polly demands fPIC
    @ARCH_C_FLAGS = '-latomic -fPIC'
    @ARCH_CXX_FLAGS = '-latomic -fPIC'
    # Because getting this error:
    # ld.lld: error: relocation R_386_PC32 cannot be used against symbol isl_map_fix_si; recompile with -fPIC
    # So as per https://github.com/openssl/openssl/issues/11305#issuecomment-602003528
    @ARCH_LDFLAGS='-Wl,-znotext'
  when 'x86_64'
    #LLVM_TARGETS_TO_BUILD = 'X86;AMDGPU'
    LLVM_TARGETS_TO_BUILD = 'all'
    @ARCH_C_FLAGS = '-fPIC'
    @ARCH_CXX_FLAGS = '-fPIC'
    @ARCH_LDFLAGS=''
  end
  @ARCH_C_LTO_FLAGS = "#{@ARCH_C_FLAGS} -flto=thin -fuse-ld=lld"
  @ARCH_CXX_LTO_FLAGS = "#{@ARCH_CXX_FLAGS} -flto=thin -fuse-ld=lld"
  LLVM_PROJECTS_TO_BUILD = 'clang;clang-tools-extra;libcxx;libcxxabi;libunwind;lldb;compiler-rt;lld;polly;openmp'
  
  # Using Targets 'all' for non-i686 because otherwise mesa complains.
  # This may be patched upstream as per 
  # https://reviews.llvm.org/rG1de56d6d13c083c996dfd44a32041dacae037d66
  #LLVM_TARGETS_TO_BUILD = 'all'

  def self.patch
    # This keeps system libraries from being linked in as dependencies on a build host image, such as in docker.
    # Uncomment the rest of this section if you need to.
    #system "sudo rm /lib#{CREW_LIB_SUFFIX}/libncurses.so.5 || true"
    #system "sudo rm /usr/lib#{CREW_LIB_SUFFIX}/libform.so || true"
    #system "sudo ln -s #{CREW_LIB_PREFIX}/libncurses.so.6 /lib#{CREW_LIB_SUFFIX}/libncurses.so.5 || true"
    #system "sudo ln -s #{CREW_LIB_PREFIX}/libform.so /usr/lib#{CREW_LIB_SUFFIX}/libform.so || true"
  end

  def self.build
    ############################################################
    puts "Building LLVM Targets: #{LLVM_TARGETS_TO_BUILD}".lightgreen
    puts "Building LLVM Projects: #{LLVM_PROJECTS_TO_BUILD}".lightgreen
    ############################################################
    ############################################################
    puts "Setting compile to use python3".lightgreen
    ############################################################
    system "grep -rl '#!.*python' | xargs sed -i '1s/python$/python3/'"
    
    ############################################################
    # puts "Downloading binutils #{BINUTILS_BRANCH} src to enable gold plugin build".lightgreen
    ############################################################
    # system "git config --global advice.detachedHead false"
    # As per https://github.com/SVF-tools/SVF/wiki/Install-LLVM-Gold-Plugin-on-Ubuntu
    # system "git clone --depth 1 --branch #{BINUTILS_BRANCH} git://sourceware.org/git/binutils-gdb.git binutils"
    
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "echo '#!/bin/bash
machine=\$(gcc -dumpmachine)
version=\$(gcc -dumpversion)
gnuc_lib=#{CREW_LIB_PREFIX}/gcc/\${machine}/\${version}
clang -B \${gnuc_lib} -L \${gnuc_lib} \"\$@\"' > clc"
      system "echo '#!/bin/bash
machine=\$(gcc -dumpmachine)
version=\$(gcc -dumpversion)
cxx_sys=#{CREW_PREFIX}/include/c++/\${version}
cxx_inc=#{CREW_PREFIX}/include/c++/\${version}/\${machine}
gnuc_lib=#{CREW_LIB_PREFIX}/gcc/\${machine}/\${version}
clang++ -fPIC  -rtlib=compiler-rt -stdlib=libc++ -cxx-isystem \${cxx_sys} -I \${cxx_inc} -B \${gnuc_lib} -L \${gnuc_lib} \"\$@\"' > clc++"
        system "env PATH=#{CREW_LIB_PREFIX}/ccache/bin:#{CREW_PREFIX}/bin:/usr/bin:/bin LD=ld.lld \
            cmake -G Ninja \
            -DLLVM_ENABLE_LTO=Thin \
            -DCMAKE_C_COMPILER=$(which clang) \
            -DCMAKE_CXX_COMPILER=$(which clang++) \
            -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
            -DLLVM_DEFAULT_TARGET_TRIPLE=#{CREW_BUILD} \
            -DCMAKE_C_COMPILER_TARGET=#{CREW_BUILD} \
            -DCMAKE_ASM_COMPILER_TARGET=#{CREW_BUILD} \
            -DLLVM_TARGETS_TO_BUILD=\'#{LLVM_TARGETS_TO_BUILD}' \
            -DCMAKE_BUILD_TYPE=Release \
            -DLLVM_LIBDIR_SUFFIX='#{CREW_LIB_SUFFIX}' \
            -DCMAKE_LINKER=$(which ld.lld) \
            -D_CMAKE_TOOLCHAIN_PREFIX=llvm- \
            -DLLVM_BUILD_LLVM_DYLIB=ON \
            -DLLVM_LINK_LLVM_DYLIB=ON \
            -DLLVM_CCACHE_BUILD=ON \
            -DLLVM_ENABLE_FFI=ON \
            -DLLVM_ENABLE_RTTI=ON \
            -DCMAKE_C_FLAGS='#{@ARCH_C_LTO_FLAGS}' \
            -DCMAKE_CXX_FLAGS='#{@ARCH_CXX_LTO_FLAGS}' \
            -DCMAKE_EXE_LINKER_FLAGS='#{@ARCH_LDFLAGS}' \
            -DLLVM_PARALLEL_LINK_JOBS=1 \
            -DPYTHON_EXECUTABLE=$(which python3) \
            -DLLVM_INSTALL_UTILS=ON \
            -DLLVM_BINUTILS_INCDIR='#{CREW_PREFIX}/include' \
            -DLLVM_OPTIMIZED_TABLEGEN=ON \
            -DLLVM_ENABLE_TERMINFO=ON \
            -DLLVM_ENABLE_PROJECTS='#{LLVM_PROJECTS_TO_BUILD}' \
            -DLIBUNWIND_C_FLAGS='-fno-exceptions -funwind-tables' \
            -DLIBUNWIND_CXX_FLAGS='-fno-exceptions -funwind-tables' \
            -DLIBUNWIND_SUPPORTS_FUNWIND_TABLES_FLAG=ON \
            -DLIBUNWIND_SUPPORTS_FNO_EXCEPTIONS_FLAG=ON \
            -DCOMPILER_RT_BUILD_SANITIZERS=OFF \
            -DCOMPILER_RT_BUILD_LIBFUZZER=OFF \
            -DCOMPILER_RT_BUILD_BUILTINS=ON \
            -DCOMPILER_RT_DEFAULT_TARGET_ONLY=ON \
            -Wno-dev \
            ../llvm"
      system 'ninja'
    end
  end

  def self.install
    Dir.chdir("builddir") do
      system "install -Dm755 clc #{CREW_DEST_PREFIX}/bin/clc"
      system "install -Dm755 clc++ #{CREW_DEST_PREFIX}/bin/clc++"
      system "DESTDIR=#{CREW_DEST_DIR} ninja install"
      FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/bfd-plugins"
      FileUtils.ln_s "lib#{CREW_LIB_SUFFIX}/LLVMgold.so", "#{CREW_DEST_LIB_PREFIX}/bfd-plugins/"
    end
  end
  

  def self.check
    Dir.chdir("builddir") do
      #system "ninja check-llvm || true"
      #system "ninja check-clang || true"
      #system "ninja check-lld || true"
    end
  end

  def self.postinstall
    puts
    puts "To compile programs, use 'clang' or 'clang++'.".lightblue
    puts
    puts "To avoid the repeated use of switch options,".lightblue
    puts "try the wrapper scripts 'clc' or 'clc++'.".lightblue
    puts
    puts "For more information, see http://llvm.org/pubs/2008-10-04-ACAT-LLVM-Intro.pdf".lightblue
    puts
  end
end

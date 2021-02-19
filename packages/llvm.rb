require 'package'

class Llvm < Package
  description 'The LLVM Project is a collection of modular and reusable compiler and toolchain technologies. The optional packages clang, lld, lldb, polly, compiler-rt, libcxx, libcxxabi, and openmp are included.'
  homepage 'http://llvm.org/'
  @_ver = '11.1.0'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/llvm/llvm-project/archive/llvmorg-#{@_ver}.tar.gz"
  source_sha256 '53a0719f3f4b0388013cfffd7b10c7d5682eece1929a9553c722348d1f866e79'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-11.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-11.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-11.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-11.1.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'ba0520a8d5bfa90efb3eb13a530c8d4052f9e7572aa30dd42dfc624b88a0251e',
     armv7l: 'ba0520a8d5bfa90efb3eb13a530c8d4052f9e7572aa30dd42dfc624b88a0251e',
       i686: '3a514f96c846d777c838fef6c585d2278abf2a586bfaeacfd3e2bccc9ffce838',
     x86_64: '5b9e01c2411ea174293fc1d33b2dbf91f7001eb3cc3eda2e849b80f6f0dcb3c8'
  })

  depends_on 'ocaml' => :build
  depends_on 'pygments' => :build
  depends_on 'ccache' => :build
  # depends_on 'llvm_stage1' => :build # Not needed with a functional
  # prior llvm 11 build.

  case ARCH
  when 'aarch64', 'armv7l'
    # LLVM_TARGETS_TO_BUILD = 'ARM;AArch64;AMDGPU'
    LLVM_TARGETS_TO_BUILD = 'all'.freeze
    @ARCH_C_FLAGS = "-fPIC -march=armv7-a -mfloat-abi=hard -ccc-gcc-name #{CREW_BUILD}"
    @ARCH_CXX_FLAGS = "-fPIC -march=armv7-a -mfloat-abi=hard -ccc-gcc-name #{CREW_BUILD}"
    @ARCH_LDFLAGS = ''
    @ARCH_LTO_LDFLAGS = "#{@ARCH_LDFLAGS} -flto=thin"
  when 'i686'
    LLVM_TARGETS_TO_BUILD = 'X86'.freeze
    # Because ld.lld: error: undefined symbol: __atomic_store
    # Polly demands fPIC
    @ARCH_C_FLAGS = '-latomic -fPIC'
    @ARCH_CXX_FLAGS = '-latomic -fPIC'
    # Because getting this error:
    # ld.lld: error: relocation R_386_PC32 cannot be used against symbol isl_map_fix_si; recompile with -fPIC
    # So as per https://github.com/openssl/openssl/issues/11305#issuecomment-602003528
    @ARCH_LDFLAGS = '-Wl,-znotext'
    @ARCH_LTO_LDFLAGS = "#{@ARCH_LDFLAGS} -flto=thin"
  when 'x86_64'
    # LLVM_TARGETS_TO_BUILD = 'X86;AMDGPU'
    LLVM_TARGETS_TO_BUILD = 'all'.freeze
    @ARCH_C_FLAGS = '-fPIC'
    @ARCH_CXX_FLAGS = '-fPIC'
    @ARCH_LDFLAGS = ''
    @ARCH_LTO_LDFLAGS = "#{@ARCH_LDFLAGS} -flto=thin"
  end
  @ARCH_C_LTO_FLAGS = "#{@ARCH_C_FLAGS} -flto=thin -fuse-ld=lld"
  @ARCH_CXX_LTO_FLAGS = "#{@ARCH_CXX_FLAGS} -flto=thin -fuse-ld=lld"
  LLVM_PROJECTS_TO_BUILD = 'clang;clang-tools-extra;libcxx;libcxxabi;libunwind;lldb;compiler-rt;lld;polly;openmp'.freeze

  # Using Targets 'all' for non-i686 because otherwise mesa complains.
  # This may be patched upstream as per
  # https://reviews.llvm.org/rG1de56d6d13c083c996dfd44a32041dacae037d66
  # LLVM_TARGETS_TO_BUILD = 'all'

  def self.patch
    # This keeps system libraries from being linked in as dependencies on a build host image, such as in docker.
    # Uncomment the rest of this section if you need to.
    # system "sudo rm /lib#{CREW_LIB_SUFFIX}/libncurses.so.5 || true"
    # system "sudo rm /usr/lib#{CREW_LIB_SUFFIX}/libform.so || true"
    # system "sudo ln -s #{CREW_LIB_PREFIX}/libncurses.so.6 /lib#{CREW_LIB_SUFFIX}/libncurses.so.5 || true"
    # system "sudo ln -s #{CREW_LIB_PREFIX}/libform.so /usr/lib#{CREW_LIB_SUFFIX}/libform.so || true"
  end

  def self.build
    ############################################################
    puts "Building LLVM Targets: #{LLVM_TARGETS_TO_BUILD}".lightgreen
    puts "Building LLVM Projects: #{LLVM_PROJECTS_TO_BUILD}".lightgreen
    ############################################################
    ############################################################
    puts 'Setting compile to use python3'.lightgreen
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
            -DCMAKE_EXE_LINKER_FLAGS='#{@ARCH_LTO_LDFLAGS}' \
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
    Dir.chdir('builddir') do
      system "DESTDIR=#{CREW_DEST_DIR} ninja install"
      FileUtils.install 'clc', "#{CREW_DEST_PREFIX}/bin/clc", mode: 0o755
      FileUtils.install 'clc++', "#{CREW_DEST_PREFIX}/bin/clc++", mode: 0o755
      FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/bfd-plugins"
      FileUtils.ln_s "lib#{CREW_LIB_SUFFIX}/LLVMgold.so", "#{CREW_DEST_LIB_PREFIX}/bfd-plugins/"
    end
  end

  def self.check
    Dir.chdir('builddir') do
      # system "ninja check-llvm || true"
      # system "ninja check-clang || true"
      # system "ninja check-lld || true"
    end
  end

  def self.postinstall
    puts
    puts "To compile programs, use 'clang' or 'clang++'.".lightblue
    puts
    puts 'To avoid the repeated use of switch options,'.lightblue
    puts "try the wrapper scripts 'clc' or 'clc++'.".lightblue
    puts
    puts 'For more information, see http://llvm.org/pubs/2008-10-04-ACAT-LLVM-Intro.pdf'.lightblue
    puts
  end
end

require 'package'

class Llvm_stage1 < Package
  description 'THIS IS NOT THE LLVM PACKAGE. This is only a Limited Stage 1 compile of LLVM.'
  homepage 'http://llvm.org/'
  @_ver = '11.1.0-rc1'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/llvm/llvm-project/archive/llvmorg-#{@_ver}.tar.gz"
  source_sha256 'e610297041129a5c5b24355a988c99c7452ee7105ee2355334a8c521b988eb3c'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_stage1-11.1.0-rc1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_stage1-11.1.0-rc1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_stage1-11.1.0-rc1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_stage1-11.1.0-rc1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '863dd7cae43abef88dfe25c60e0dda1f8d59756f8c8fbb111989a3669dca0a16',
      armv7l: '863dd7cae43abef88dfe25c60e0dda1f8d59756f8c8fbb111989a3669dca0a16',
        i686: '84a5a2a381af8c789fcb895d1ae62dc1932b3ad1ad423e8351e37aa9be5e2490',
      x86_64: 'ddb9e88444729174b0c6f4de883910ce78e8fa489e0831acdf92daaf4561e9af',
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

  case ARCH
  when 'aarch64','armv7l'
    #LLVM_TARGETS_TO_BUILD = 'ARM;AArch64;AMDGPU'
    @ARCH_C_FLAGS = '-march=armv7-a -mfloat-abi=hard'
    @ARCH_CXX_FLAGS = '-march=armv7-a -mfloat-abi=hard'
    LLVM_PROJECTS_TO_BUILD = 'clang;clang-tools-extra;libcxx;libcxxabi;lld'
  when 'i686','x86_64'
    #LLVM_TARGETS_TO_BUILD = 'X86;AMDGPU'
    @ARCH_C_FLAGS = '-fPIC'
    @ARCH_CXX_FLAGS = '-fPIC'
    LLVM_PROJECTS_TO_BUILD = 'clang;clang-tools-extra;libcxx;libcxxabi;libunwind;lld'
  end
  
  @ARCH_C_LTO_FLAGS = "#{@ARCH_C_FLAGS} -flto"
  @ARCH_CXX_LTO_FLAGS = "#{@ARCH_CXX_FLAGS} -flto"
  
  # Using Targets 'all' because otherwise mesa complains.
  # This may be patched upstream as per 
  # https://reviews.llvm.org/rG1de56d6d13c083c996dfd44a32041dacae037d66
  LLVM_TARGETS_TO_BUILD = 'all'
  LLVM_VERSION = version.split("-")[0]

  def self.build
    ############################################################
    puts "Building LLVM Targets: #{LLVM_TARGETS_TO_BUILD}".lightgreen
    puts "Building LLVM Projects: #{LLVM_PROJECTS_TO_BUILD}".lightgreen
    ############################################################
    ############################################################
    puts "Setting compile to use python3".lightgreen
    ############################################################
    system "grep -rl '#!.*python' | xargs sed -i '1s/python$/python3/'"
    
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
        system "env PATH=#{CREW_LIB_PREFIX}/ccache/bin:#{CREW_PREFIX}/bin:/usr/bin:/bin FC= \
            cmake -G Ninja \
            -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
            -DLLVM_DEFAULT_TARGET_TRIPLE=#{CREW_BUILD} \
            -DLLVM_TARGETS_TO_BUILD=\'#{LLVM_TARGETS_TO_BUILD}' \
            -DCMAKE_BUILD_TYPE=Release \
            -DLLVM_LIBDIR_SUFFIX='#{CREW_LIB_SUFFIX}' \
            -DCMAKE_LINKER=$(which ld.gold) \
            -D_CMAKE_TOOLCHAIN_PREFIX=gcc- \
            -DLLVM_BUILD_LLVM_DYLIB=ON \
            -DLLVM_LINK_LLVM_DYLIB=ON \
            -DLLVM_ENABLE_FFI=ON \
            -DLLVM_ENABLE_RTTI=ON \
            -DCMAKE_C_FLAGS='#{@ARCH_C_FLAGS}' \
            -DCMAKE_CXX_FLAGS='#{@ARCH_CXX_FLAGS}' \
            -DLLVM_PARALLEL_LINK_JOBS=1 \
            -DPYTHON_EXECUTABLE=$(which python3) \
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
      system 'ninja -j1'
    end
  end

  def self.install
    Dir.chdir("builddir") do
      FileUtils.install 'clc', "#{CREW_DEST_PREFIX}/bin/clc", mode: 0755
      FileUtils.install 'clc++', "#{CREW_DEST_PREFIX}/bin/clc++", mode: 0755
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

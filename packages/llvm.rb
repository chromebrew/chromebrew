require 'package'

class Llvm < Package
  description 'The LLVM Project is a collection of modular and reusable compiler and toolchain technologies. The optional packages clang, lld, lldb, polly, compiler-rt, libcxx, libcxxabi and openmp are included.'
  homepage 'http://llvm.org/'
  version '11.0.1'
  compatibility 'all'
  source_url 'https://github.com/llvm/llvm-project/archive/llvmorg-11.0.1.tar.gz'
  source_sha256 '9c7ad8e8ec77c5bde8eb4afa105a318fd1ded7dff3747d14f012758719d7171b'


  depends_on 'ld_default' => :build
  depends_on 'ocaml' => :build
  depends_on 'libedit'
  depends_on 'libtirpc'
  depends_on 'swig'
  depends_on 'pygments' => :build
  depends_on 'ccache' => :build


  ARCH_ACTUAL = `uname -m`.strip
  case ARCH_ACTUAL
  when 'armv8l', 'aarch64',  'armv7l'
    #LLVM_TARGETS_TO_BUILD = 'ARM;AArch64;AMDGPU'
    ARCH_C_FLAGS = '-march=armv7-a -mfloat-abi=hard'
    ARCH_C_LTO_FLAGS = '-march=armv7-a -mfloat-abi=hard -flto'
    ARCH_CXX_FLAGS = '-march=armv7-a -mfloat-abi=hard'
    ARCH_CXX_LTO_FLAGS = '-march=armv7-a -mfloat-abi=hard -flto'
  when 'i686','x86_64'
    #LLVM_TARGETS_TO_BUILD = 'X86;AMDGPU'
    ARCH_C_FLAGS = ''
    ARCH_C_LTO_FLAGS = '-flto'
    ARCH_CXX_FLAGS = ''
    ARCH_CXX_LTO_FLAGS = '-flto'
  end
  # Using Targets 'all' because otherwise mesa complains.
  # This may be patched upstream as per 
  # https://reviews.llvm.org/rG1de56d6d13c083c996dfd44a32041dacae037d66
  LLVM_TARGETS_TO_BUILD = 'all'
  # OpenMP was having issues compiling with -flto
  LLVM_PROJECTS_TO_BUILD = 'clang;clang-tools-extra;libcxx;libcxxabi;libunwind;lldb;compiler-rt;lld;polly'
  LLVM_VERSION = version.split("-")[0]
  
  BINUTILS_BRANCH = 'gdb-10.1-release'

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
    puts "Downloading binutils #{BINUTILS_BRANCH} src to enable gold plugin build".lightgreen
    ############################################################
    # As per https://github.com/SVF-tools/SVF/wiki/Install-LLVM-Gold-Plugin-on-Ubuntu
    system "git clone --depth 1 --branch #{BINUTILS_BRANCH} git://sourceware.org/git/binutils-gdb.git binutils"
    
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
        system "env PATH=#{CREW_LIB_PREFIX}/ccache/bin:#{CREW_PREFIX}/bin:/usr/bin:/bin \
            cmake -G Ninja \
            -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
            -DLLVM_DEFAULT_TARGET_TRIPLE=#{ARCH}-cros-linux-gnu \
            -DLLVM_TARGETS_TO_BUILD=\'#{LLVM_TARGETS_TO_BUILD}' \
            -DCMAKE_BUILD_TYPE=Release \
            -DLLVM_LIBDIR_SUFFIX='#{CREW_LIB_SUFFIX}' \
            -DCMAKE_LINKER=$(which ld.gold) \
            -DLLVM_BUILD_LLVM_DYLIB=ON \
            -DLLVM_LINK_LLVM_DYLIB=ON \
            -DLLVM_ENABLE_FFI=ON \
            -DLLVM_ENABLE_RTTI=ON \
            -DCMAKE_C_FLAGS='#{ARCH_C_LTO_FLAGS}' \
            -DCMAKE_CXX_FLAGS='#{ARCH_CXX_LTO_FLAGS}' \
            -DLLVM_PARALLEL_LINK_JOBS=1 \
            -DPYTHON_EXECUTABLE=$(which python3) \
            -DLLVM_INSTALL_UTILS=ON \
            -DLLVM_BINUTILS_INCDIR='../binutils/include' \
            -DLIBUNWIND_C_FLAGS='-fno-exceptions -funwind-tables' \
            -DLIBUNWIND_CXX_FLAGS='-fno-exceptions -funwind-tables' \
            -DLIBUNWIND_SUPPORTS_FUNWIND_TABLES_FLAG=ON \
            -DLIBUNWIND_SUPPORTS_FNO_EXCEPTIONS_FLAG=ON \
            -DLLVM_OPTIMIZED_TABLEGEN=ON \
            -DLLVM_ENABLE_PROJECTS='#{LLVM_PROJECTS_TO_BUILD}' \
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
      FileUtils.cp "lib#{CREW_LIB_SUFFIX}/LLVMgold.so", "#{CREW_DEST_LIB_PREFIX}/bfd-plugins/"
      FileUtils.cp Dir.glob("lib#{CREW_LIB_SUFFIX}/libLTO.*"), "#{CREW_DEST_LIB_PREFIX}/bfd-plugins/"
    end
  end
  
  def self.check
    Dir.chdir("builddir") do
      system "ninja check-llvm || true"
      system "ninja check-clang || true"
      system "ninja check-lld || true"
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

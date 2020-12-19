require 'package'

class Llvm < Package
  description 'The LLVM Project is a collection of modular and reusable compiler and toolchain technologies. The optional packages clang, lld, lldb, polly, compiler-rt, libcxx, libcxxabi and openmp are included.'
  homepage 'http://llvm.org/'
  version '11.0.1-rc2'
  compatibility 'all'
  source_url 'https://github.com/llvm/llvm-project/archive/llvmorg-11.0.1-rc2.tar.gz'
  source_sha256 'c217780b9903eabf0fdb8ed227ae50b623d3f82afb9ac36beffbc81acbc6ff6c'



  depends_on 'ld_default' => :build

  depends_on 'ocaml' => :build
  depends_on 'libedit'
  depends_on 'libtirpc'
  depends_on 'swig'
  depends_on 'pygments'

  #ARCH_ACTUAL = `uname -m`.strip
  #case ARCH_ACTUAL
  #when 'armv8l', 'aarch64', 'armv7l'
    #LLVM_TARGETS_TO_BUILD = 'ARM;AArch64;AMDGPU'
  #when 'i686','x86_64'
    #LLVM_TARGETS_TO_BUILD = 'X86;AMDGPU'
  #end
  LLVM_TARGETS_TO_BUILD = 'all'
  LLVM_VERSION = version.split("-")[0]

  def self.build
    ############################################################
    puts "Setting compile to use python3".lightgreen
    ############################################################
    system "grep -rl '#!.*python' | xargs sed -i '1s/python$/python3/'"
    
    ############################################################
    puts "Downloading binutils src to enable gold plugin build".lightgreen
    ############################################################
    # As per https://github.com/SVF-tools/SVF/wiki/Install-LLVM-Gold-Plugin-on-Ubuntu
    system "git clone --depth 1 git://sourceware.org/git/binutils-gdb.git binutils"
    
    
    
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
        system "cmake -G Ninja \
            -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
            -DLLVM_DEFAULT_TARGET_TRIPLE=#{ARCH}-cros-linux-gnu \
            -DLLVM_TARGETS_TO_BUILD=\'#{LLVM_TARGETS_TO_BUILD}' \
            -DCMAKE_BUILD_TYPE=Release \
            -DLLVM_LIBDIR_SUFFIX='#{CREW_LIB_SUFFIX}' \
            -DLLVM_BUILD_LLVM_DYLIB=ON \
            -DLLVM_ENABLE_RTTI=ON \
            -DLLVM_USE_LINKER=gold \
            -DLLVM_INSTALL_UTILS=ON \
            -DLLVM_BINUTILS_INCDIR='../binutils/include' \
            -DLLVM_ENABLE_PROJECTS='clang;clang-tools-extra;libcxx;libcxxabi;libunwind;lldb;compiler-rt;lld;polly;openmp' \
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
      #FileUtils.cp lib#{CREW_LIB_SUFFIX}/LLVMgold.so "#{CREW_DEST_LIB_PREFIX}/bfd-plugins/"
      #FileUtils.cp lib#{CREW_LIB_SUFFIX}/libLTO.* "#{CREW_DEST_LIB_PREFIX}/bfd-plugins/"
      system "cp lib#{CREW_LIB_SUFFIX}/LLVMgold.so #{CREW_DEST_LIB_PREFIX}/bfd-plugins/"
      system "cp lib#{CREW_LIB_SUFFIX}/libLTO.* #{CREW_DEST_LIB_PREFIX}/bfd-plugins/"
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

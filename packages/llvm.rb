require 'package'

class Llvm < Package
  description 'The LLVM Project is a collection of modular and reusable compiler and toolchain technologies. The optional packages clang, lld, lldb, polly, compiler-rt, libcxx, libcxxabi and openmp are included.'
  homepage 'http://llvm.org/'
  version '8.0.0'
  source_url 'https://releases.llvm.org/8.0.0/llvm-8.0.0.src.tar.xz'
  source_sha256 '8872be1b12c61450cacc82b3d153eab02be2546ef34fa3580ed14137bb26224c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-8.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-8.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-8.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-8.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6bd8d139f2a3b5cc6279ced8f4d812a6cc3f7f546cd624aeefe7a2e3827321d0',
     armv7l: '6bd8d139f2a3b5cc6279ced8f4d812a6cc3f7f546cd624aeefe7a2e3827321d0',
       i686: '523c470af763d5a5c4e437fbfb7d34274f390e77e53d7422633882377abebd73',
     x86_64: 'fafbc33d4635f50819ade2f184c618d70abceb6d17bd39e758a31158bbe2766f',
  })

  depends_on 'ld_default' => :build
  depends_on 'graphviz' => :build # for docs
  depends_on 'python27' => :build # for test suite
  depends_on 'sphinx' => :build
  depends_on 'ocaml' => :build
  depends_on 'libedit'
  depends_on 'libtirpc'
  depends_on 'swig'

  def self.preinstall

    ############################# Download clang (tools) ###########################################
    url_clang = "https://releases.llvm.org/#{version}/cfe-#{version}.src.tar.xz"
    uri_clang = URI.parse url_clang
    filename_clang = File.basename(uri_clang.path)
    sha256sum_clang = '084c115aab0084e63b23eee8c233abb6739c399e29966eaeccfc6e088e0b736b'

    if File.exist?(filename_clang) && Digest::SHA256.hexdigest( File.read("./#{filename_clang}") ) == sha256sum_clang
      puts "Unpacking clang source code".yellow
    else
      puts "Downloading clang".yellow
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_clang, '-o', filename_clang)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_clang}") ) == sha256sum_clang
      puts "Clang archive downloaded".lightgreen
    end

    system "tar", "xf", "cfe-#{version}.src.tar.xz", "-C", "tools"
    puts "Clang source code unpacked".lightgreen
    system "rm -rf tools/clang"  # remove possible existing folder
    system "mv -v tools/cfe-#{version}.src tools/clang"

    ############################# Download lld (tools) ###########################################
    url_lld = "https://releases.llvm.org/#{version}/lld-#{version}.src.tar.xz"
    uri_lld = URI.parse url_lld
    filename_lld = File.basename(uri_lld.path)
    sha256sum_lld = '9caec8ec922e32ffa130f0fb08e4c5a242d7e68ce757631e425e9eba2e1a6e37'

    if File.exist?(filename_lld) && Digest::SHA256.hexdigest( File.read("./#{filename_lld}") ) == sha256sum_lld
      puts "Unpacking lld source code".yellow
    else
      puts "Downloading lld".yellow
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_lld, '-o', filename_lld)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_lld}") ) == sha256sum_lld
      puts "Lld archive downloaded".lightgreen
    end

    system "tar", "xf", "lld-#{version}.src.tar.xz", "-C", "tools"
    puts "Lld source code unpacked".lightgreen
    system "rm -rf tools/lld"
    system "mv -v tools/lld-#{version}.src tools/lld"

    ############################# Download lldb (tools) ###########################################
    url_lldb = "https://releases.llvm.org/#{version}/lldb-#{version}.src.tar.xz"
    uri_lldb = URI.parse url_lldb
    filename_lldb = File.basename(uri_lldb.path)
    sha256sum_lldb = '49918b9f09816554a20ac44c5f85a32dc0a7a00759b3259e78064d674eac0373'

    if File.exist?(filename_lldb) && Digest::SHA256.hexdigest( File.read("./#{filename_lldb}") ) == sha256sum_lldb
      puts "Unpacking lldb source code".yellow
    else
      puts "Downloading lldb".yellow
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_lldb, '-o', filename_lldb)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_lldb}") ) == sha256sum_lldb
      puts "Lldb archive downloaded".lightgreen
    end

    system "tar", "xf", "lldb-#{version}.src.tar.xz", "-C", "tools"
    puts "Lldb source code unpacked".lightgreen
    system "rm -rf tools/lldb"
    system "mv -v tools/lldb-#{version}.src tools/lldb"

    ############################# Download polly (tools) ###########################################
    url_polly = "https://releases.llvm.org/#{version}/polly-#{version}.src.tar.xz"
    uri_polly = URI.parse url_polly
    filename_polly = File.basename(uri_polly.path)
    sha256sum_polly = 'e3f5a3d6794ef8233af302c45ceb464b74cdc369c1ac735b6b381b21e4d89df4'

    if File.exist?(filename_polly) && Digest::SHA256.hexdigest( File.read("./#{filename_polly}") ) == sha256sum_polly
      puts "Unpacking polly source code".yellow
    else
      puts "Downloading polly".yellow
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_polly, '-o', filename_polly)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_polly}") ) == sha256sum_polly
      puts "Polly archive downloaded".lightgreen
    end

    system "tar", "xf", "polly-#{version}.src.tar.xz", "-C", "tools"
    puts "Polly source code unpacked".lightgreen
    system "rm -rf tools/polly"
    system "mv -v tools/polly-#{version}.src tools/polly"

    # Due to compilation error, extra clang tools are not included.
    ############################## Download extra clang tools (tools) ###########################################
    #url_extra_tools = "https://releases.llvm.org/#{version}/clang-tools-extra-#{version}.src.tar.xz"
    #uri_extra_tools = URI.parse url_extra_tools
    #filename_extra_tools = File.basename(uri_extra_tools.path)
    #sha256sum_extra_tools = '4f00122be408a7482f2004bcf215720d2b88cf8dc78b824abb225da8ad359d4b'

    #if File.exist?(filename_extra_tools) && Digest::SHA256.hexdigest( File.read("./#{filename_extra_tools}") ) == sha256sum_extra_tools
    #  puts "Unpacking extra_tools source code".yellow
    #  system "tar", "xf", "clang-tools-extra-#{version}.src.tar.xz", "-C", "tools"
    #  puts "Polly source code unpacked".lightgreen
    #  system "rm -rf tools/extra"
    #  system "mv -v tools/clang-tools-extra-#{version}.src tools/extra"
    #else
    #  puts "Downloading extra_tools".yellow
    #  system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_extra_tools, '-o', filename_extra_tools)
    #  abort 'Checksum mismatch. :/ Try again.'.lightred unless
    #    Digest::SHA256.hexdigest( File.read("./#{filename_extra_tools}") ) == sha256sum_extra_tools
    #  puts "Clang extra tools archive downloaded".lightgreen
    #  system "tar", "xf", "clang-tools-extra-#{version}.src.tar.xz", "-C", "tools"
    #  puts "Clang extra tools source code unpacked".lightgreen
    #  system "mv -v tools/clang-tools-extra-#{version}.src tools/extra"
    #end

    ############################# Download compiler-rt (projects) ####################################
    url_compiler_rt = "https://releases.llvm.org/#{version}/compiler-rt-#{version}.src.tar.xz"
    uri_compiler_rt = URI.parse url_compiler_rt
    filename_compiler_rt = File.basename(uri_compiler_rt.path)
    sha256sum_compiler_rt = 'b435c7474f459e71b2831f1a4e3f1d21203cb9c0172e94e9d9b69f50354f21b1'

    if File.exist?(filename_compiler_rt) && Digest::SHA256.hexdigest( File.read("./#{filename_compiler_rt}") ) == sha256sum_compiler_rt
      puts "Unpacking compiler-rt source code".yellow
    else
      puts "Downloading compiler-rt".yellow
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_compiler_rt, '-o', filename_compiler_rt)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_compiler_rt}") ) == sha256sum_compiler_rt
      puts "Compiler-rt archive downloaded".lightgreen
    end

    system "tar", "xf", "compiler-rt-#{version}.src.tar.xz", "-C", "projects"
    puts "Compiler-rt source code unpacked".lightgreen
    system "rm -rf projects/compiler-rt"
    system "mv -v projects/compiler-rt-#{version}.src projects/compiler-rt"

    ############################# Download libcxx (procjects) ####################################
    url_libcxx = "https://releases.llvm.org/#{version}/libcxx-#{version}.src.tar.xz"
    uri_libcxx = URI.parse url_libcxx
    filename_libcxx = File.basename(uri_libcxx.path)
    sha256sum_libcxx = 'c2902675e7c84324fb2c1e45489220f250ede016cc3117186785d9dc291f9de2'

    if File.exist?(filename_libcxx) && Digest::SHA256.hexdigest( File.read("./#{filename_libcxx}") ) == sha256sum_libcxx
      puts "Unpacking libcxx source code".yellow
    else
      puts "Downloading libcxx".yellow
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_libcxx, '-o', filename_libcxx)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_libcxx}") ) == sha256sum_libcxx
      puts "Libcxx archive downloaded".lightgreen
    end

    system "tar", "xf", "libcxx-#{version}.src.tar.xz", "-C", "projects"
    puts "Libcxx source code unpacked".lightgreen
    system "rm -rf projects/libcxx"
    system "mv -v projects/libcxx-#{version}.src projects/libcxx"

    ############################# Download libcxxabi (procjects) ####################################
    url_libcxxabi = "https://releases.llvm.org/#{version}/libcxxabi-#{version}.src.tar.xz"
    uri_libcxxabi = URI.parse url_libcxxabi
    filename_libcxxabi = File.basename(uri_libcxxabi.path)
    sha256sum_libcxxabi = 'c2d6de9629f7c072ac20ada776374e9e3168142f20a46cdb9d6df973922b07cd'

    if File.exist?(filename_libcxxabi) && Digest::SHA256.hexdigest( File.read("./#{filename_libcxxabi}") ) == sha256sum_libcxxabi
      puts "Unpacking libcxxabi source code".yellow
    else
      puts "Downloading libcxxabi".yellow
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_libcxxabi, '-o', filename_libcxxabi)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_libcxxabi}") ) == sha256sum_libcxxabi
      puts "Libcxxabi archive downloaded".lightgreen
    end

    system "tar", "xf", "libcxxabi-#{version}.src.tar.xz", "-C", "projects"
    puts "Libcxxabi source code unpacked".lightgreen
    system "rm -rf projects/libcxxabi"
    system "mv -v projects/libcxxabi-#{version}.src projects/libcxxabi"

    ############################# Download libomp (procjects) ####################################
    url_openmp = "https://releases.llvm.org/#{version}/openmp-#{version}.src.tar.xz"
    uri_openmp = URI.parse url_openmp
    filename_openmp = File.basename(uri_openmp.path)
    sha256sum_openmp = 'f7b1705d2f16c4fc23d6531f67d2dd6fb78a077dd346b02fed64f4b8df65c9d5'

    if File.exist?(filename_openmp) && Digest::SHA256.hexdigest( File.read("./#{filename_openmp}") ) == sha256sum_openmp
      puts "Unpacking openmp source code".yellow
    else
      puts "Downloading openmp".yellow
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_openmp, '-o', filename_openmp)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_openmp}") ) == sha256sum_openmp
      puts "Openmp archive downloaded".lightgreen
    end

    system "tar", "xf", "openmp-#{version}.src.tar.xz", "-C", "projects"
    puts "Openmp source code unpacked".lightgreen
    system "rm -rf projects/openmp"
    system "mv -v projects/openmp-#{version}.src projects/openmp"

    ############################# Download libunwind (procjects) ####################################
    url_libunwind = "https://releases.llvm.org/#{version}/libunwind-#{version}.src.tar.xz"
    uri_libunwind = URI.parse url_libunwind
    filename_libunwind = File.basename(uri_libunwind.path)
    sha256sum_libunwind = 'ff243a669c9cef2e2537e4f697d6fb47764ea91949016f2d643cb5d8286df660'

    if File.exist?(filename_libunwind) && Digest::SHA256.hexdigest( File.read("./#{filename_libunwind}") ) == sha256sum_libunwind
      puts "Unpacking libunwind source code".yellow
    else
      puts "Downloading libunwind".yellow
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_libunwind, '-o', filename_libunwind)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_libunwind}") ) == sha256sum_libunwind
      puts "Libunwind archive downloaded".lightgreen
    end

    system "tar", "xf", "libunwind-#{version}.src.tar.xz", "-C", "projects"
    puts "Libunwind source code unpacked".lightgreen
    system "rm -rf projects/libunwind"
    system "mv -v projects/libunwind-#{version}.src projects/libunwind"

    ############################# Download test-suite (procjects) ####################################
    #url_testsuite = "https://releases.llvm.org/#{version}/test-suite-#{version}.src.tar.xz"
    #uri_testsuite = URI.parse url_testsuite
    #filename_testsuite = File.basename(uri_testsuite.path)
    #sha256sum_testsuite = 'b567d761189e172650ec733fb9bcc4eeabf3f58ae97d85dec9e66392bb37b7ea'

    #if File.exist?(filename_testsuite) && Digest::SHA256.hexdigest( File.read("./#{filename_testsuite}") ) == sha256sum_testsuite
    #  puts "Unpacking test-suite source code".yellow
    #else
    #  puts "Downloading test suite".yellow
    #  system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_testsuite, '-o', filename_testsuite)
    #  abort 'Checksum mismatch. :/ Try again.'.lightred unless
    #    Digest::SHA256.hexdigest( File.read("./#{filename_testsuite}") ) == sha256sum_testsuite
    #  puts "Test-suite archive downloaded".lightgreen
    #end

    #  system "tar", "xf", "test-suite-#{version}.src.tar.xz", "-C", "projects"
    #  puts "Test-suite source code unpacked".lightgreen
    #  system "rm -rf projects/test-suite"
    #  system "mv -v projects/test-suite-#{version}.src projects/test-suite"

    ############################################################
    puts "Optional packages are ready".lightgreen
    ############################################################

  end

  def self.build
    puts 'Change to GOLD linker.'.orange
    original_default = `ld_default g`.chomp
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
clang++ -rtlib=compiler-rt -stdlib=libc++ -cxx-isystem \${cxx_sys} -I \${cxx_inc} -B \${gnuc_lib} -L \${gnuc_lib} \"\$@\"' > clc++"
      case ARCH
      when "x86_64"
        system "cmake",
               "-DCURSES_INCLUDE_PATH='#{CREW_PREFIX}/include/ncursesw'",
               "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
               "-DLLVM_LIBDIR_SUFFIX=64",
               "-DBUILD_SHARED_LIBS=ON",
               "-DCMAKE_BUILD_TYPE=Release",
               "-Wno-dev",
               ".."
               # Fix for file INSTALL cannot find ".../lib64/python2.7" error.
               # See http://lists.llvm.org/pipermail/lldb-dev/2015-June/007633.html.
               system "sed -i '40,43d' tools/lldb/scripts/cmake_install.cmake"
      else # armv7l, aarch64 or i686
        system "cmake",
               "-DCURSES_INCLUDE_PATH='#{CREW_PREFIX}/include/ncursesw'",
               "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
               "-DBUILD_SHARED_LIBS=ON",
               "-DCMAKE_BUILD_TYPE=Release",
               "-Wno-dev",
               ".."
      end
      system 'make'
    end
    system "ld_default #{original_default}"
  end

  def self.install
    Dir.chdir("builddir") do
      system "install -Dm755 clc #{CREW_DEST_PREFIX}/bin/clc"
      system "install -Dm755 clc++ #{CREW_DEST_PREFIX}/bin/clc++"
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
  
  #def self.check
  #  Dir.chdir("builddir") do
  #    system "make -k -j#{CREW_NPROC} check-llvm"
  #    system "make -k -j#{CREW_NPROC} check-clang"
  #    system "make -k -j#{CREW_NPROC} check-lld"
  #  end
  #end

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

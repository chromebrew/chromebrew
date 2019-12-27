require 'package'

class Llvm < Package
  description 'The LLVM Project is a collection of modular and reusable compiler and toolchain technologies. The optional packages clang, lld, lldb, polly, compiler-rt, libcxx, libcxxabi and openmp are included.'
  homepage 'http://llvm.org/'
  version '9.0.0'
  source_url 'https://releases.llvm.org/9.0.0/llvm-9.0.0.src.tar.xz'
  source_sha256 'd6a0565cf21f22e9b4353b2eb92622e8365000a9e90a16b09b56f8157eabfe84'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-9.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-9.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-9.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-9.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c33a3b92a7038784b4ff4231171a17cf556143f9b5d875aee64aeabc0ab458ab',
     armv7l: 'c33a3b92a7038784b4ff4231171a17cf556143f9b5d875aee64aeabc0ab458ab',
       i686: '2f93321ba8228faefa513fefdb2ce974874e99a24d7aaf2f672fb99791e0e3db',
     x86_64: '1dd75d41f5188bd598bbe77a059698cc27627c4bc24602061a90f62f9cf39294',
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
    sha256sum_clang = '7ba81eef7c22ca5da688fdf9d88c20934d2d6b40bfe150ffd338900890aa4610'

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
    sha256sum_lld = '31c6748b235d09723fb73fea0c816ed5a3fab0f96b66f8fbc546a0fcc8688f91'

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
    sha256sum_lldb = '1e4c2f6a1f153f4b8afa2470d2e99dab493034c1ba8b7ffbbd7600de016d0794'

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
    sha256sum_polly = 'a4fa92283de725399323d07f18995911158c1c5838703f37862db815f513d433'

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
    #sha256sum_extra_tools = 'ea1c86ce352992d7b6f6649bc622f6a2707b9f8b7153e9f9181a35c76aa3ac10'

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
    sha256sum_compiler_rt = '56e4cd96dd1d8c346b07b4d6b255f976570c6f2389697347a6c3dcb9e820d10e'

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
    sha256sum_libcxx = '3c4162972b5d3204ba47ac384aa456855a17b5e97422723d4758251acf1ed28c'

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
    sha256sum_libcxxabi = '675041783565c906ac2f7f8b2bc5c40f14d871ecfa8ade34855aa18de95530e9'

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
    sha256sum_openmp = '9979eb1133066376cc0be29d1682bc0b0e7fb541075b391061679111ae4d3b5b'

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
    sha256sum_libunwind = '976a8d09e1424fb843210eecec00a506b956e6c31adda3b0d199e945be0d0db2'

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
    #sha256sum_testsuite = '2ba3cde840c1c0ef744c93ae6a921207dbb9ccbb39f93f7ace9252e5203307cf'

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
        system 'cmake',
               "-DCURSES_INCLUDE_PATH='#{CREW_PREFIX}/include/ncursesw'",
               "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
               '-DCMAKE_BUILD_TYPE=Release',
               '-DLLVM_LIBDIR_SUFFIX=64',
               '-DBUILD_SHARED_LIBS=ON',
               '-DLLVM_ENABLE_RTTI=ON',
               '-Wno-dev',
               '..'
               # Fix for file INSTALL cannot find ".../lib64/python2.7" error.
               # See http://lists.llvm.org/pipermail/lldb-dev/2015-June/007633.html.
               system "sed -i '40,43d' tools/lldb/scripts/cmake_install.cmake"
      else # armv7l, aarch64 or i686
        system 'cmake',
               "-DCURSES_INCLUDE_PATH='#{CREW_PREFIX}/include/ncursesw'",
               "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
               '-DCMAKE_BUILD_TYPE=Release',
               '-DBUILD_SHARED_LIBS=ON',
               '-DLLVM_ENABLE_RTTI=ON',
               '-Wno-dev',
               '..'
      end
      system 'make'
    end
    system "ld_default #{original_default}"
  end

  def self.install
    Dir.chdir("builddir") do
      system "install -Dm755 clc #{CREW_DEST_PREFIX}/bin/clc"
      system "install -Dm755 clc++ #{CREW_DEST_PREFIX}/bin/clc++"
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
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

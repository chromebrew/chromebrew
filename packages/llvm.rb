require 'package'

class Llvm < Package
  description 'The LLVM Project is a collection of modular and reusable compiler and toolchain technologies. The optional packages clang, lld, lldb, polly, compiler-rt, libcxx, libcxxabi and openmp are included.'
  homepage 'http://llvm.org/'
  version '10.0.0'
  compatibility 'all'
  source_url 'https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.0/llvm-10.0.0.src.tar.xz'
  source_sha256 'df83a44b3a9a71029049ec101fb0077ecbbdf5fe41e395215025779099a98fdf'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-10.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-10.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-10.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-10.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0498ed55a9d3171c3f523c156822508f1b2a2d506ca87d6961427ae5165f6a34',
     armv7l: '0498ed55a9d3171c3f523c156822508f1b2a2d506ca87d6961427ae5165f6a34',
       i686: '8c4173f7de0525948ce60fed8d7fef7a3f1cb4632b650e6623eed6b4a0db7cce',
     x86_64: 'b4751906ff72b3e4e2fcfbf3380bdc17907e3463c86ba059113369c459c7783f',
  })

  depends_on 'ld_default' => :build
  depends_on 'graphviz' => :build # for docs
  depends_on 'python27' => :build # for test suite
  depends_on 'sphinx' => :build
  depends_on 'ocaml' => :build
  depends_on 'libedit'
  depends_on 'libtirpc'
  depends_on 'swig'

  def self.build
    ############################# Download clang (tools) ###########################################
    url_clang = "https://github.com/llvm/llvm-project/releases/download/llvmorg-#{version}/clang-#{version}.src.tar.xz"
    uri_clang = URI.parse url_clang
    filename_clang = File.basename(uri_clang.path)
    sha256sum_clang = '885b062b00e903df72631c5f98b9579ed1ed2790f74e5646b4234fa084eacb21'

    if File.exist?(filename_clang) && Digest::SHA256.hexdigest( File.read("./#{filename_clang}") ) == sha256sum_clang
      puts "Unpacking clang source code".yellow
    else
      puts "Downloading clang".yellow
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_clang, '-o', filename_clang)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_clang}") ) == sha256sum_clang
      puts "Clang archive downloaded".lightgreen
    end

    system "tar", "xf", "clang-#{version}.src.tar.xz", "-C", "tools"
    puts "Clang source code unpacked".lightgreen
    system "rm -rf tools/clang"  # remove possible existing folder
    system "mv -v tools/clang-#{version}.src tools/clang"

    ############################# Download lld (tools) ###########################################
    url_lld = "https://github.com/llvm/llvm-project/releases/download/llvmorg-#{version}/lld-#{version}.src.tar.xz"
    uri_lld = URI.parse url_lld
    filename_lld = File.basename(uri_lld.path)
    sha256sum_lld = 'b9a0d7c576eeef05bc06d6e954938a01c5396cee1d1e985891e0b1cf16e3d708'

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
    url_lldb = "https://github.com/llvm/llvm-project/releases/download/llvmorg-#{version}/lldb-#{version}.src.tar.xz"
    uri_lldb = URI.parse url_lldb
    filename_lldb = File.basename(uri_lldb.path)
    sha256sum_lldb = 'dd1ffcb42ed033f5167089ec4c6ebe84fbca1db4a9eaebf5c614af09d89eb135'

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
    url_polly = "https://github.com/llvm/llvm-project/releases/download/llvmorg-#{version}/polly-#{version}.src.tar.xz"
    uri_polly = URI.parse url_polly
    filename_polly = File.basename(uri_polly.path)
    sha256sum_polly = '35fba6ed628896fe529be4c10407f1b1c8a7264d40c76bced212180e701b4d97'

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
    url_compiler_rt = "https://github.com/llvm/llvm-project/releases/download/llvmorg-#{version}/compiler-rt-#{version}.src.tar.xz"
    uri_compiler_rt = URI.parse url_compiler_rt
    filename_compiler_rt = File.basename(uri_compiler_rt.path)
    sha256sum_compiler_rt = '6a7da64d3a0a7320577b68b9ca4933bdcab676e898b759850e827333c3282c75'

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
    url_libcxx = "https://github.com/llvm/llvm-project/releases/download/llvmorg-#{version}/libcxx-#{version}.src.tar.xz"
    uri_libcxx = URI.parse url_libcxx
    filename_libcxx = File.basename(uri_libcxx.path)
    sha256sum_libcxx = '270f8a3f176f1981b0f6ab8aa556720988872ec2b48ed3b605d0ced8d09156c7'

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
    url_libcxxabi = "https://github.com/llvm/llvm-project/releases/download/llvmorg-#{version}/libcxxabi-#{version}.src.tar.xz"
    uri_libcxxabi = URI.parse url_libcxxabi
    filename_libcxxabi = File.basename(uri_libcxxabi.path)
    sha256sum_libcxxabi = 'e71bac75a88c9dde455ad3f2a2b449bf745eafd41d2d8432253b2964e0ca14e1'

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
    url_openmp = "https://github.com/llvm/llvm-project/releases/download/llvmorg-#{version}/openmp-#{version}.src.tar.xz"
    uri_openmp = URI.parse url_openmp
    filename_openmp = File.basename(uri_openmp.path)
    sha256sum_openmp = '3b9ff29a45d0509a1e9667a0feb43538ef402ea8cfc7df3758a01f20df08adfa'

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
    url_libunwind = "https://github.com/llvm/llvm-project/releases/download/llvmorg-#{version}/libunwind-#{version}.src.tar.xz"
    uri_libunwind = URI.parse url_libunwind
    filename_libunwind = File.basename(uri_libunwind.path)
    sha256sum_libunwind = '09dc5ecc4714809ecf62908ae8fe8635ab476880455287036a2730966833c626'

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
clang++ -fPIC  -rtlib=compiler-rt -stdlib=libc++ -cxx-isystem \${cxx_sys} -I \${cxx_inc} -B \${gnuc_lib} -L \${gnuc_lib} \"\$@\"' > clc++"
      case ARCH
      when "x86_64"
        system 'cmake',
               "-DCURSES_INCLUDE_PATH='#{CREW_PREFIX}/include/ncursesw'",
               "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
               '-DCMAKE_CXX_FLAGS="-fPIC"',
               '-DCMAKE_BUILD_TYPE=Release',
               '-DLLVM_LIBDIR_SUFFIX=64',
               '-DBUILD_SHARED_LIBS=ON',
               '-DLLVM_ENABLE_RTTI=ON',
               '-Wno-dev',
               '..'
               # Fix for file INSTALL cannot find ".../lib64/python2.7" error.
               # See http://lists.llvm.org/pipermail/lldb-dev/2015-June/007633.html.
               system "sed -i '40,43d' tools/lldb/cmake_install.cmake"
      else # armv7l, aarch64 or i686
        system 'cmake',
               "-DCURSES_INCLUDE_PATH='#{CREW_PREFIX}/include/ncursesw'",
               "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
               '-DCMAKE_CXX_FLAGS="-fPIC"',
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

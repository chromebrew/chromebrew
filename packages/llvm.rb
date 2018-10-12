require 'package'

class Llvm < Package
  description 'The LLVM Project is a collection of modular and reusable compiler and toolchain technologies. The optional packages clang, lld, lldb, polly, compiler-rt, libcxx, libcxxabi and openmp are included.'
  homepage 'http://llvm.org/'
  version '7.0.0-1'
  source_url 'https://releases.llvm.org/7.0.0/llvm-7.0.0.src.tar.xz'
  source_sha256 '8bc1f844e6cbde1b652c19c1edebc1864456fd9c78b8c1bea038e51b363fe222'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-7.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-7.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-7.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-7.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'dc4fffeb9486455e59cc7f81225fbd5a486840a4bbeac832861fe7c37f61021e',
     armv7l: 'dc4fffeb9486455e59cc7f81225fbd5a486840a4bbeac832861fe7c37f61021e',
       i686: '166d984b4b6b43454ecaac5ef02e5848644285e3ea4cd838c97317d0cf2b4767',
     x86_64: '882659f61d8a60a1022307f350d67a772d8a014ad2f70fb59091612aceb0dd78',
  })

  depends_on 'python27' => :build # for test suite
  depends_on 'graphviz' => :build
  depends_on 'sphinx' => :build
  depends_on 'libedit'
  depends_on 'libtirpc'
  depends_on 'swig'

  def self.preinstall

    ############################# Download clang (tools) ###########################################
    url_clang = 'https://releases.llvm.org/7.0.0/cfe-7.0.0.src.tar.xz'
    uri_clang = URI.parse url_clang
    filename_clang = File.basename(uri_clang.path)
    sha256sum_clang = '550212711c752697d2f82c648714a7221b1207fd9441543ff4aa9e3be45bba55'

    if File.exist?(filename_clang) && Digest::SHA256.hexdigest( File.read("./#{filename_clang}") ) == sha256sum_clang
      puts "Unpacking clang source code".yellow
    else
      puts "Downloading clang".yellow
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_clang, '-o', filename_clang)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_clang}") ) == sha256sum_clang
      puts "Clang archive downloaded".lightgreen
    end

    system "tar", "xf", "cfe-7.0.0.src.tar.xz", "-C", "tools"
    puts "Clang source code unpacked".lightgreen
    system "rm -rf tools/clang"  # remove possible existing folder
    system "mv -v tools/cfe-7.0.0.src tools/clang"

    ############################# Download lld (tools) ###########################################
    url_lld = 'https://releases.llvm.org/7.0.0/lld-7.0.0.src.tar.xz'
    uri_lld = URI.parse url_lld
    filename_lld = File.basename(uri_lld.path)
    sha256sum_lld = 'fbcf47c5e543f4cdac6bb9bbbc6327ff24217cd7eafc5571549ad6d237287f9c'

    if File.exist?(filename_lld) && Digest::SHA256.hexdigest( File.read("./#{filename_lld}") ) == sha256sum_lld
      puts "Unpacking lld source code".yellow
    else
      puts "Downloading lld".yellow
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_lld, '-o', filename_lld)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_lld}") ) == sha256sum_lld
      puts "Lld archive downloaded".lightgreen
    end

    system "tar", "xf", "lld-7.0.0.src.tar.xz", "-C", "tools"
    puts "Lld source code unpacked".lightgreen
    system "rm -rf tools/lld"
    system "mv -v tools/lld-7.0.0.src tools/lld"

    ############################# Download lldb (tools) ###########################################
    url_lldb = 'https://releases.llvm.org/7.0.0/lldb-7.0.0.src.tar.xz'
    uri_lldb = URI.parse url_lldb
    filename_lldb = File.basename(uri_lldb.path)
    sha256sum_lldb = '7ff6d8fee49977d25b3b69be7d22937b92592c7609cf283ed0dcf9e5cd80aa32'

    if File.exist?(filename_lldb) && Digest::SHA256.hexdigest( File.read("./#{filename_lldb}") ) == sha256sum_lldb
      puts "Unpacking lldb source code".yellow
    else
      puts "Downloading lldb".yellow
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_lldb, '-o', filename_lldb)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_lldb}") ) == sha256sum_lldb
      puts "Lldb archive downloaded".lightgreen
    end

    system "tar", "xf", "lldb-7.0.0.src.tar.xz", "-C", "tools"
    puts "Lldb source code unpacked".lightgreen
    system "rm -rf tools/lldb"
    system "mv -v tools/lldb-7.0.0.src tools/lldb"

    ############################# Download polly (tools) ###########################################
    url_polly = 'https://releases.llvm.org/7.0.0/polly-7.0.0.src.tar.xz'
    uri_polly = URI.parse url_polly
    filename_polly = File.basename(uri_polly.path)
    sha256sum_polly = '919810d3249f4ae79d084746b9527367df18412f30fe039addbf941861c8534b'

    if File.exist?(filename_polly) && Digest::SHA256.hexdigest( File.read("./#{filename_polly}") ) == sha256sum_polly
      puts "Unpacking polly source code".yellow
    else
      puts "Downloading polly".yellow
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_polly, '-o', filename_polly)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_polly}") ) == sha256sum_polly
      puts "Polly archive downloaded".lightgreen
    end

    system "tar", "xf", "polly-7.0.0.src.tar.xz", "-C", "tools"
    puts "Polly source code unpacked".lightgreen
    system "rm -rf tools/polly"
    system "mv -v tools/polly-7.0.0.src tools/polly"

    #  Due to compilation error, extra clang tools are not included.
    ############################## Download extra clang tools (tools) ###########################################
    #url_extra_tools = 'https://releases.llvm.org/7.0.0/clang-tools-extra-7.0.0.src.tar.xz'
    #uri_extra_tools = URI.parse url_extra_tools
    #filename_extra_tools = File.basename(uri_extra_tools.path)
    #sha256sum_extra_tools = '937c5a8c8c43bc185e4805144744799e524059cac877a44d9063926cd7a19dbe'

    #if File.exist?(filename_extra_tools) && Digest::SHA256.hexdigest( File.read("./#{filename_extra_tools}") ) == sha256sum_extra_tools
    #  puts "Unpacking extra_tools source code".yellow
    #  system "tar", "xf", "clang-tools-extra-7.0.0.src.tar.xz", "-C", "tools"
    #  puts "Polly source code unpacked".lightgreen
    #  system "rm -rf tools/extra"
    #  system "mv -v tools/clang-tools-extra-7.0.0.src tools/extra"
    #else
    #  puts "Downloading extra_tools".yellow
    #  system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_extra_tools, '-o', filename_extra_tools)
    #  abort 'Checksum mismatch. :/ Try again.'.lightred unless
    #    Digest::SHA256.hexdigest( File.read("./#{filename_extra_tools}") ) == sha256sum_extra_tools
    #  puts "Clang extra tools archive downloaded".lightgreen
    #
    #  system "tar", "xf", "clang-tools-extra-7.0.0.src.tar.xz", "-C", "tools"
    #  puts "Clang extra tools source code unpacked".lightgreen
    #  system "mv -v tools/clang-tools-extra-7.0.0.src tools/extra"
    #end

    ############################# Download compiler-rt (projects) ####################################
    url_compiler_rt = 'https://releases.llvm.org/7.0.0/compiler-rt-7.0.0.src.tar.xz'
    uri_compiler_rt = URI.parse url_compiler_rt
    filename_compiler_rt = File.basename(uri_compiler_rt.path)
    sha256sum_compiler_rt = 'bdec7fe3cf2c85f55656c07dfb0bd93ae46f2b3dd8f33ff3ad6e7586f4c670d6'

    if File.exist?(filename_compiler_rt) && Digest::SHA256.hexdigest( File.read("./#{filename_compiler_rt}") ) == sha256sum_compiler_rt
      puts "Unpacking compiler-rt source code".yellow
    else
      puts "Downloading compiler-rt".yellow
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_compiler_rt, '-o', filename_compiler_rt)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_compiler_rt}") ) == sha256sum_compiler_rt
      puts "Compiler-rt archive downloaded".lightgreen
    end

    system "tar", "xf", "compiler-rt-7.0.0.src.tar.xz", "-C", "projects"
    puts "Compiler-rt source code unpacked".lightgreen
    system "rm -rf projects/compiler-rt"
    system "mv -v projects/compiler-rt-7.0.0.src projects/compiler-rt"

    ############################# Download libcxx (procjects) ####################################
    url_libcxx = 'https://releases.llvm.org/7.0.0/libcxx-7.0.0.src.tar.xz'
    uri_libcxx = URI.parse url_libcxx
    filename_libcxx = File.basename(uri_libcxx.path)
    sha256sum_libcxx = '9b342625ba2f4e65b52764ab2061e116c0337db2179c6bce7f9a0d70c52134f0'

    if File.exist?(filename_libcxx) && Digest::SHA256.hexdigest( File.read("./#{filename_libcxx}") ) == sha256sum_libcxx
      puts "Unpacking libcxx source code".yellow
    else
      puts "Downloading libcxx".yellow
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_libcxx, '-o', filename_libcxx)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_libcxx}") ) == sha256sum_libcxx
      puts "Libcxx archive downloaded".lightgreen
    end

    system "tar", "xf", "libcxx-7.0.0.src.tar.xz", "-C", "projects"
    puts "Libcxx source code unpacked".lightgreen
    system "rm -rf projects/libcxx"
    system "mv -v projects/libcxx-7.0.0.src projects/libcxx"

    ############################# Download libcxxabi (procjects) ####################################
    url_libcxxabi = 'https://releases.llvm.org/7.0.0/libcxxabi-7.0.0.src.tar.xz'
    uri_libcxxabi = URI.parse url_libcxxabi
    filename_libcxxabi = File.basename(uri_libcxxabi.path)
    sha256sum_libcxxabi = '9b45c759ff397512eae4d938ff82827b1bd7ccba49920777e5b5e460baeb245f'

    if File.exist?(filename_libcxxabi) && Digest::SHA256.hexdigest( File.read("./#{filename_libcxxabi}") ) == sha256sum_libcxxabi
      puts "Unpacking libcxxabi source code".yellow
    else
      puts "Downloading libcxxabi".yellow
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_libcxxabi, '-o', filename_libcxxabi)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_libcxxabi}") ) == sha256sum_libcxxabi
      puts "Libcxxabi archive downloaded".lightgreen
    end

    system "tar", "xf", "libcxxabi-7.0.0.src.tar.xz", "-C", "projects"
    puts "Libcxxabi source code unpacked".lightgreen
    system "rm -rf projects/libcxxabi"
    system "mv -v projects/libcxxabi-7.0.0.src projects/libcxxabi"

    ############################# Download libomp (procjects) ####################################
    url_openmp = 'https://releases.llvm.org/7.0.0/openmp-7.0.0.src.tar.xz'
    uri_openmp = URI.parse url_openmp
    filename_openmp = File.basename(uri_openmp.path)
    sha256sum_openmp = '30662b632f5556c59ee9215c1309f61de50b3ea8e89dcc28ba9a9494bba238ff'

    if File.exist?(filename_openmp) && Digest::SHA256.hexdigest( File.read("./#{filename_openmp}") ) == sha256sum_openmp
      puts "Unpacking openmp source code".yellow
    else
      puts "Downloading openmp".yellow
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_openmp, '-o', filename_openmp)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_openmp}") ) == sha256sum_openmp
      puts "Openmp archive downloaded".lightgreen
    end

    system "tar", "xf", "openmp-7.0.0.src.tar.xz", "-C", "projects"
    puts "Openmp source code unpacked".lightgreen
    system "rm -rf projects/openmp"
    system "mv -v projects/openmp-7.0.0.src projects/openmp"

    ############################# Download libunwind (procjects) ####################################
    url_libunwind = 'https://releases.llvm.org/7.0.0/libunwind-7.0.0.src.tar.xz'
    uri_libunwind = URI.parse url_libunwind
    filename_libunwind = File.basename(uri_libunwind.path)
    sha256sum_libunwind = '50aee87717421e70450f1e093c6cd9a27f2b111025e1e08d64d5ace36e338a9c'

    if File.exist?(filename_libunwind) && Digest::SHA256.hexdigest( File.read("./#{filename_libunwind}") ) == sha256sum_libunwind
      puts "Unpacking libunwind source code".yellow
    else
      puts "Downloading libunwind".yellow
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_libunwind, '-o', filename_libunwind)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_libunwind}") ) == sha256sum_libunwind
      puts "Libunwind archive downloaded".lightgreen
    end

    system "tar", "xf", "libunwind-7.0.0.src.tar.xz", "-C", "projects"
    puts "Libunwind source code unpacked".lightgreen
    system "rm -rf projects/libunwind"
    system "mv -v projects/libunwind-7.0.0.src projects/libunwind"

    ############################# Download test-suite (procjects) ####################################
    #url_testsuite = 'https://releases.llvm.org/7.0.0/test-suite-7.0.0.src.tar.xz'
    #uri_testsuite = URI.parse url_testsuite
    #filename_testsuite = File.basename(uri_testsuite.path)
    #sha256sum_testsuite = '97f0dc3fe4ad3613218115e914096e82b38c9aa865d5e3fbc8bd6b82ca7ee343'

    #if File.exist?(filename_testsuite) && Digest::SHA256.hexdigest( File.read("./#{filename_testsuite}") ) == sha256sum_testsuite
    #  puts "Unpacking test-suite source code".yellow
    #else
    #  puts "Downloading test suite".yellow
    #  system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_testsuite, '-o', filename_testsuite)
    #  abort 'Checksum mismatch. :/ Try again.'.lightred unless
    #    Digest::SHA256.hexdigest( File.read("./#{filename_testsuite}") ) == sha256sum_testsuite
    #  puts "Test-suite archive downloaded".lightgreen
    #end

    #  system "tar", "xf", "test-suite-7.0.0.src.tar.xz", "-C", "projects"
    #  puts "Test-suite source code unpacked".lightgreen
    #  system "rm -rf projects/test-suite"
    #  system "mv -v projects/test-suite-7.0.0.src projects/test-suite"

    ############################################################
    puts "Optional packages are ready".lightgreen
    ############################################################

  end

  def self.build
    gcc_ver = '7.3.0'
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      case ARCH
      when "x86_64"
        system "echo '#!/bin/bash
gnuc_lib=#{CREW_LIB_PREFIX}/gcc/x86_64-cros-linux-gnu/#{gcc_ver}
clang -B \${gnuc_lib} -L \${gnuc_lib} \"\$@\"' > clc"
        system "echo '#!/bin/bash
cxx_sys=#{CREW_PREFIX}/include/c++/#{gcc_ver}
cxx_inc=#{CREW_PREFIX}/include/c++/#{gcc_ver}/x86_64-cros-linux-gnu
gnuc_lib=#{CREW_LIB_PREFIX}/gcc/x86_64-cros-linux-gnu/#{gcc_ver}
clang++ -cxx-isystem \${cxx_sys} -I \${cxx_inc} -B \${gnuc_lib} -L \${gnuc_lib} \"\$@\"' > clc++"
        system "cmake",
               "-DCURSES_INCLUDE_PATH='#{CREW_PREFIX}/include/ncursesw'",
               "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
               "-DLLVM_LIBDIR_SUFFIX=64",
               "-DBUILD_SHARED_LIBS=ON",
               "-DCMAKE_BUILD_TYPE=Release",
               "-DLLVM_TARGETS_TO_BUILD=host;AMDGPU",
               "-Wno-dev",
               ".."
               # Fix for file INSTALL cannot find ".../lib64/python2.7" error.
               # See http://lists.llvm.org/pipermail/lldb-dev/2015-June/007633.html.
               system "sed -i '40,43d' tools/lldb/scripts/cmake_install.cmake"
      when "i686"
        system "echo '#!/bin/bash
gnuc_lib=#{CREW_LIB_PREFIX}/gcc/i686-cros-linux-gnu/#{gcc_ver}
clang -B \${gnuc_lib} -L \${gnuc_lib} \"\$@\"' > clc"
        system "echo '#!/bin/bash
cxx_sys=#{CREW_PREFIX}/include/c++/#{gcc_ver}
cxx_inc=#{CREW_PREFIX}/include/c++/#{gcc_ver}/i686-cros-linux-gnu
gnuc_lib=#{CREW_LIB_PREFIX}/gcc/i686-cros-linux-gnu/#{gcc_ver}
clang++ -cxx-isystem \${cxx_sys} -I \${cxx_inc} -B \${gnuc_lib} -L \${gnuc_lib} \"\$@\"' > clc++"
        system "cmake",
               "-DCURSES_INCLUDE_PATH='#{CREW_PREFIX}/include/ncursesw'",
               "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
               "-DBUILD_SHARED_LIBS=ON",
               "-DCMAKE_BUILD_TYPE=Release",
               "-DLLVM_TARGETS_TO_BUILD=host;X86",
               "-Wno-dev",
               ".."
      else # armv7l or aarch64
        system "echo '#!/bin/bash
gnuc_lib=#{CREW_LIB_PREFIX}/gcc/armv7l-cros-linux-gnueabihf/#{gcc_ver}
clang -B \${gnuc_lib} -L \${gnuc_lib} \"\$@\"' > clc"
        system "echo '#!/bin/bash
cxx_sys=#{CREW_PREFIX}/include/c++/#{gcc_ver}
cxx_inc=#{CREW_PREFIX}/include/c++/#{gcc_ver}/armv7l-cros-linux-gnueabihf
gnuc_lib=#{CREW_LIB_PREFIX}/gcc/armv7l-cros-linux-gnueabihf/#{gcc_ver}
clang++ -cxx-isystem \${cxx_sys} -I \${cxx_inc} -B \${gnuc_lib} -L \${gnuc_lib} \"\$@\"' > clc++"
        system "cmake",
               "-DCURSES_INCLUDE_PATH='#{CREW_PREFIX}/include/ncursesw'",
               "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
               "-DBUILD_SHARED_LIBS=ON",
               "-DCMAKE_BUILD_TYPE=Release",
               "-DLLVM_TARGETS_TO_BUILD=host;ARM",
               "-Wno-dev",
               ".."
      end
      system 'make'
    end
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

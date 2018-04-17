require 'package'

class Llvm6 < Package
  description 'The LLVM Project (version 6.0.0) is a collection of modular and reusable compiler and toolchain technologies. The optional packages including clang, lld, polly, compiler-rt, libcxx, libcxxabi and openmp are included.'
  homepage 'http://llvm.org/'
  version '6.0.0'
  source_url 'https://llvm.org/releases/6.0.0/llvm-6.0.0.src.tar.xz'
  source_sha256 '1ff53c915b4e761ef400b803f07261ade637b0c269d99569f18040f3dcee4408'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm6-6.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/llvm6-6.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/llvm6-6.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm6-6.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '32928186027577aee2618dc4826b09900de5842eac4d5dc82743a917f9fcaae1',
     armv7l: '32928186027577aee2618dc4826b09900de5842eac4d5dc82743a917f9fcaae1',
       i686: 'bbd3d9b82dfc1a98740eef4c784407caa9aa7c7f1d183374b11962ba5fdebcb6',
     x86_64: '664c18423806dbd1987e3e81c64b44cf6f447a671aae46eeb25cbcba597d714e',
  })

  depends_on 'python27' => :build # for test suite
  depends_on 'icu4c'              # fix uconv.h missing
  depends_on 'libtirpc'
  
  def self.preinstall
    
    ############################# Download clang (tools) ###########################################
    url_clang = 'https://llvm.org/releases/6.0.0/cfe-6.0.0.src.tar.xz'
    uri_clang = URI.parse url_clang
    filename_clang = File.basename(uri_clang.path)
    sha256sum_clang = 'e07d6dd8d9ef196cfc8e8bb131cbd6a2ed0b1caf1715f9d05b0f0eeaddb6df32'
    
    if File.exist?(filename_clang) && Digest::SHA256.hexdigest( File.read("./#{filename_clang}") ) == sha256sum_clang
      puts "Clang source code exists and perform unpacking".lightred
      system "tar", "xf", "cfe-6.0.0.src.tar.xz", "-C", "tools"
      puts "Clang source code unpacked".lightgreen
      system "rm -rf tools/clang"  # remove possible existing folder
      system "mv -v tools/cfe-6.0.0.src tools/clang"
    else
      puts "Downloading clang".lightred
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_clang, '-o', filename_clang)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_clang}") ) == sha256sum_clang
      puts "Clang archive downloaded".lightgreen
      
      system "tar", "xf", "cfe-6.0.0.src.tar.xz", "-C", "tools"
      puts "Clang source code unpacked".lightgreen
      system "mv -v tools/cfe-6.0.0.src tools/clang"
    end

    ############################# Download lld (tools) ###########################################
    url_lld = 'https://releases.llvm.org/6.0.0/lld-6.0.0.src.tar.xz'
    uri_lld = URI.parse url_lld
    filename_lld = File.basename(uri_lld.path)
    sha256sum_lld = '6b8c4a833cf30230c0213d78dbac01af21387b298225de90ab56032ca79c0e0b'

    if File.exist?(filename_lld) && Digest::SHA256.hexdigest( File.read("./#{filename_lld}") ) == sha256sum_lld
      puts "Lld source code exists and perform unpacking".lightred
      system "tar", "xf", "lld-6.0.0.src.tar.xz", "-C", "tools"
      puts "Lld source code unpacked".lightgreen
      system "rm -rf tools/lld"
      system "mv -v tools/lld-6.0.0.src tools/lld"
    else
      puts "Downloading lld".lightred
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_lld, '-o', filename_lld)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_lld}") ) == sha256sum_lld
      puts "Lld archive downloaded".lightgreen
      
      system "tar", "xf", "lld-6.0.0.src.tar.xz", "-C", "tools"
      puts "Lld source code unpacked".lightgreen
      system "mv -v tools/lld-6.0.0.src tools/lld"
    end

    ############################# Download polly (tools) ###########################################
    url_polly = 'https://releases.llvm.org/6.0.0/polly-6.0.0.src.tar.xz'
    uri_polly = URI.parse url_polly
    filename_polly = File.basename(uri_polly.path)
    sha256sum_polly = '47e493a799dca35bc68ca2ceaeed27c5ca09b12241f87f7220b5f5882194f59c'

    if File.exist?(filename_polly) && Digest::SHA256.hexdigest( File.read("./#{filename_polly}") ) == sha256sum_polly
      puts "Polly source code exists and perform unpacking".lightred
      system "tar", "xf", "polly-6.0.0.src.tar.xz", "-C", "tools"
      puts "Polly source code unpacked".lightgreen
      system "rm -rf tools/polly"
      system "mv -v tools/polly-6.0.0.src tools/polly"
    else
      puts "Downloading polly".lightred
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_polly, '-o', filename_polly)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_polly}") ) == sha256sum_polly
      puts "Polly archive downloaded".lightgreen
      
      system "tar", "xf", "polly-6.0.0.src.tar.xz", "-C", "tools"
      puts "Polly source code unpacked".lightgreen
      system "mv -v tools/polly-6.0.0.src tools/polly"
   end

    #  Due to compilation error, extra clang tools are not included.
    ############################# Download extra clang tools (tools) ###########################################
#    url_extra_tools = 'https://releases.llvm.org/6.0.0/clang-tools-extra-6.0.0.src.tar.xz'
#    uri_extra_tools = URI.parse url_extra_tools
#    filename_extra_tools = File.basename(uri_extra_tools.path)
#    sha256sum_extra_tools = '053b424a4cd34c9335d8918734dd802a8da612d13a26bbb88fcdf524b2d989d2'

    
#    puts "Downloading extra_tools".lightred
#    system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_extra_tools, '-o', filename_extra_tools)
#    abort 'Checksum mismatch. :/ Try again.'.lightred unless
#      Digest::SHA256.hexdigest( File.read("./#{filename_extra_tools}") ) == sha256sum_extra_tools
#    puts "Clang extra tools archive downloaded".lightgreen
#
#    system "tar", "xf", "clang-tools-extra-6.0.0.src.tar.xz", "-C", "tools"
#    puts "Clang extra tools source code unpacked".lightgreen
#    system "rsync -a tools/clang-tools-extra-6.0.0.src tools/extra "



    ############################# Download compiler-rt (projects) ####################################
    url_compiler_rt = 'https://releases.llvm.org/6.0.0/compiler-rt-6.0.0.src.tar.xz'
    uri_compiler_rt = URI.parse url_compiler_rt
    filename_compiler_rt = File.basename(uri_compiler_rt.path)
    sha256sum_compiler_rt = 'd0cc1342cf57e9a8d52f5498da47a3b28d24ac0d39cbc92308781b3ee0cea79a'

    if File.exist?(filename_compiler_rt) && Digest::SHA256.hexdigest( File.read("./#{filename_compiler_rt}") ) == sha256sum_compiler_rt
      puts "Compiler-rt source code exists and perform unpacking".lightred
      system "tar", "xf", "compiler-rt-6.0.0.src.tar.xz", "-C", "projects"
      puts "Compiler-rt source code unpacked".lightgreen
      system "rm -rf projects/compiler-rt"
      system "mv -v projects/compiler-rt-6.0.0.src projects/compiler-rt"
    else
      puts "Downloading compiler-rt".lightred
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_compiler_rt, '-o', filename_compiler_rt)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_compiler_rt}") ) == sha256sum_compiler_rt
      puts "Compiler-rt archive downloaded".lightgreen
      
      system "tar", "xf", "compiler-rt-6.0.0.src.tar.xz", "-C", "projects"
      puts "Compiler-rt source code unpacked".lightgreen
      system "mv -v projects/compiler-rt-6.0.0.src projects/compiler-rt"
   end
    
    
    
    ############################# Download libcxx (procjects) ####################################
    url_libcxx = 'https://releases.llvm.org/6.0.0/libcxx-6.0.0.src.tar.xz'
    uri_libcxx = URI.parse url_libcxx
    filename_libcxx = File.basename(uri_libcxx.path)
    sha256sum_libcxx = '70931a87bde9d358af6cb7869e7535ec6b015f7e6df64def6d2ecdd954040dd9'

    if File.exist?(filename_libcxx) && Digest::SHA256.hexdigest( File.read("./#{filename_libcxx}") ) == sha256sum_libcxx
      puts "Libcxx source code exists and perform unpacking".lightred
      system "tar", "xf", "libcxx-6.0.0.src.tar.xz", "-C", "projects"
      puts "Libcxx source code unpacked".lightgreen
      system "rm -rf projects/libcxx"
      system "mv -v projects/libcxx-6.0.0.src projects/libcxx"
    else
      puts "Downloading libcxx".lightred
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_libcxx, '-o', filename_libcxx)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_libcxx}") ) == sha256sum_libcxx
      puts "Libcxx archive downloaded".lightgreen
      
      system "tar", "xf", "libcxx-6.0.0.src.tar.xz", "-C", "projects"
      puts "Libcxx source code unpacked".lightgreen
      system "mv -v projects/libcxx-6.0.0.src projects/libcxx"
    end


    ############################# Download libcxxabi (procjects) ####################################
    url_libcxxabi = 'https://releases.llvm.org/6.0.0/libcxxabi-6.0.0.src.tar.xz'
    uri_libcxxabi = URI.parse url_libcxxabi
    filename_libcxxabi = File.basename(uri_libcxxabi.path)
    sha256sum_libcxxabi = '91c6d9c5426306ce28d0627d6a4448e7d164d6a3f64b01cb1d196003b16d641b'

    if File.exist?(filename_libcxxabi) && Digest::SHA256.hexdigest( File.read("./#{filename_libcxxabi}") ) == sha256sum_libcxxabi
      puts "Libcxxabi source code exists and perform unpacking".lightred
      system "tar", "xf", "libcxxabi-6.0.0.src.tar.xz", "-C", "projects"
      puts "Libcxxabi source code unpacked".lightgreen
      system "rm -rf projects/libcxxabi"
      system "mv -v projects/libcxxabi-6.0.0.src projects/libcxxabi"
    else
      puts "Downloading libcxxabi".lightred
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_libcxxabi, '-o', filename_libcxxabi)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_libcxxabi}") ) == sha256sum_libcxxabi
      puts "Libcxxabi archive downloaded".lightgreen
      
      system "tar", "xf", "libcxxabi-6.0.0.src.tar.xz", "-C", "projects"
      puts "Libcxxabi source code unpacked".lightgreen
      system "mv -v projects/libcxxabi-6.0.0.src projects/libcxxabi"
    end
    
    ############################# Download libomp (procjects) ####################################
    url_openmp = 'https://releases.llvm.org/6.0.0/openmp-6.0.0.src.tar.xz'
    uri_openmp = URI.parse url_openmp
    filename_openmp = File.basename(uri_openmp.path)
    sha256sum_openmp = '7c0e050d5f7da3b057579fb3ea79ed7dc657c765011b402eb5bbe5663a7c38fc'

    if File.exist?(filename_openmp) && Digest::SHA256.hexdigest( File.read("./#{filename_openmp}") ) == sha256sum_openmp
      puts "Openmp source code exists and perform unpacking".lightred
      system "tar", "xf", "openmp-6.0.0.src.tar.xz", "-C", "projects"
      puts "Openmp source code unpacked".lightgreen
      system "rm -rf projects/openmp"
      system "mv -v projects/openmp-6.0.0.src projects/openmp"
    else
      puts "Downloading openmp".lightred
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_openmp, '-o', filename_openmp)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_openmp}") ) == sha256sum_openmp
      puts "Openmp archive downloaded".lightgreen
      
      system "tar", "xf", "openmp-6.0.0.src.tar.xz", "-C", "projects"
      puts "Openmp source code unpacked".lightgreen
      system "mv -v projects/openmp-6.0.0.src projects/openmp"
    end
 
    ############################# Download libunwind (procjects) ####################################
    url_libunwind = 'https://releases.llvm.org/6.0.0/libunwind-6.0.0.src.tar.xz'
    uri_libunwind = URI.parse url_libunwind
    filename_libunwind = File.basename(uri_libunwind.path)
    sha256sum_libunwind = '256c4ed971191bde42208386c8d39e5143fa4afd098e03bd2c140c878c63f1d6'

    if File.exist?(filename_libunwind) && Digest::SHA256.hexdigest( File.read("./#{filename_libunwind}") ) == sha256sum_libunwind
      puts "Libunwind source code exists and perform unpacking".lightred
      system "tar", "xf", "libunwind-6.0.0.src.tar.xz", "-C", "projects"
      puts "Libunwind source code unpacked".lightgreen
      system "rm -rf projects/libunwind"
      system "mv -v projects/libunwind-6.0.0.src projects/libunwind"
    else
      puts "Downloading libunwind".lightred
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_libunwind, '-o', filename_libunwind)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_libunwind}") ) == sha256sum_libunwind
      puts "Libunwind archive downloaded".lightgreen
      
      system "tar", "xf", "libunwind-6.0.0.src.tar.xz", "-C", "projects"
      puts "Libunwind source code unpacked".lightgreen
      system "mv -v projects/libunwind-6.0.0.src projects/libunwind"
    end
 
  
     ############################# Download test-suite (procjects) ####################################
    url_testsuite = 'https://releases.llvm.org/6.0.0/test-suite-6.0.0.src.tar.xz'
    uri_testsuite = URI.parse url_testsuite
    filename_testsuite = File.basename(uri_testsuite.path)
    sha256sum_testsuite = '74e0055efa27b2143415148ee93b817155e6333337d9cadd4cc5d468ad3c0edf'

    if File.exist?(filename_testsuite) && Digest::SHA256.hexdigest( File.read("./#{filename_testsuite}") ) == sha256sum_testsuite
      puts "Test-suite source code exists and perform unpacking".lightred
      system "tar", "xf", "test-suite-6.0.0.src.tar.xz", "-C", "projects"
      puts "Test-suite source code unpacked".lightgreen
      system "rm -rf projects/test-suite"
      system "mv -v projects/test-suite-6.0.0.src projects/test-suite"
    else
      puts "Downloading test suite".lightred
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_testsuite, '-o', filename_testsuite)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_testsuite}") ) == sha256sum_testsuite
      puts "Test-suite archive downloaded".lightgreen
      
      system "tar", "xf", "test-suite-6.0.0.src.tar.xz", "-C", "projects"
      puts "Test-suite source code unpacked".lightgreen
      system "mv -v projects/test-suite-6.0.0.src projects/test-suite"
    end
    
    ############################################################
    puts "Optinal packages are ready".lightgreen
    ############################################################
    
  end
  
  def self.build
    system "mkdir -p builddir"
    Dir.chdir("builddir") do
      case ARCH
      when "x86_64"
        system "cmake",
               "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
               "-DLLVM_LIBDIR_SUFFIX=64",
               "-DBUILD_SHARED_LIBS=ON",
               "-DCMAKE_BUILD_TYPE=Release",
               "-DLLVM_TARGETS_TO_BUILD=host",
               "-Wno-dev",
               ".."
      else
        system "cmake",
               "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
               "-DBUILD_SHARED_LIBS=ON",
               "-DCMAKE_BUILD_TYPE=Release",
               "-DLLVM_TARGETS_TO_BUILD=host",
               "-Wno-dev",
               ".."
      end
      system "make"
    end
  end

  def self.install
    Dir.chdir("builddir") do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
  
#  def self.check
#    Dir.chdir("builddir") do
#      system "make -k check-llvm"
#      system "make -k check-clang"
#    end
#  end
end

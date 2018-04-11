require 'package'

class Gcc7 < Package
  description 'The GNU Compiler Collection includes front ends for C, C++, Objective-C, Fortran, Ada, and Go.'
  homepage 'https://www.gnu.org/software/gcc/'
  version '7.3.0-0'
  source_url 'https://github.com/gcc-mirror/gcc/archive/gcc-7_3_0-release.tar.gz'
  source_sha256 'af11c397296cab69996723b9d828c98a9bb749447ac8f7ed67458bcdb60311ed'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gcc7-7.3.0-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gcc7-7.3.0-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gcc7-7.3.0-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gcc7-7.3.0-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '19b4c233e45d2be3243c70e8e05aa7e34b6969d884768635d24b9383a025be51',
     armv7l: '19b4c233e45d2be3243c70e8e05aa7e34b6969d884768635d24b9383a025be51',
       i686: '98bf6ab14d25f7d32f4b588dcfeadaba62a6d5433214a5d8a5e63c4b78f42e31',
     x86_64: '93ba8533ce6863c23819fa24edf29d91bb030f80d17684c90d291efebd33d2c9',
  })


  depends_on 'unzip' => :build
  depends_on 'gawk' => :build
  depends_on 'dejagnu' => :build # for test
  depends_on 'gcc'    # gcc version 4.9.4
  depends_on 'icu4c'  # icu version 60.1
  
  def self.build
    # previous compile issue
    # /usr/local/bin/ld: cannot find crti.o: No such file or directory
    # /usr/local/bin/ld: cannot find /usr/lib64/libc_nonshared.a
    ENV["LIBRARY_PATH"] = "#{CREW_LIB_PREFIX}"   # fix x86_64 issues
    system "mkdir -p objdir"
    Dir.chdir("objdir") do
      case ARCH
        when 'armv7l' || 'aarch64'
          system "../configure",
                 "--prefix=#{CREW_PREFIX}",
                 "--libdir=#{CREW_LIB_PREFIX}",
                 "--build=armv7l-cros-linux-gnueabihf",
                 "--host=armv7l-cros-linux-gnueabihf",
                 "--target=armv7l-cros-linux-gnueabihf",
                 "--enable-checking=release",
                 "--enable-languages=c,c++,fortran",
                 "--disable-multilib",
                 "--enable-threads=posix",
                 "--enable-bootstrap",
                 "--disable-libmpx",
                 "--disable-static",
                 "--program-suffix=-7.3",
                 "--with-arch=armv7-a",
                 "--with-tune=cortex-a15",
                 "--with-fpu=neon",
                 "--with-float=hard",
                 "--with-default-libstdcxx-abi=gcc4-compatible"
        when "x86_64"
          system "../configure",
                 "--prefix=#{CREW_PREFIX}",
                 "--libdir=#{CREW_LIB_PREFIX}",
                 "--build=#{ARCH}-cros-linux-gnu",
                 "--host=#{ARCH}-cros-linux-gnu",
                 "--target=#{ARCH}-cros-linux-gnu",
                 "--enable-checking=release",
                 "--enable-languages=c,c++,fortran",
                 "--disable-multilib",
                 "--enable-threads=posix",
                 "--enable-bootstrap",
                 "--disable-libmpx",
                 "--disable-static",
                 "--program-suffix=-7.3",
                 "--with-arch-64=x86-64",
                 "--with-default-libstdcxx-abi=gcc4-compatible"
        when "i686"
          system "../configure",
                 "--prefix=#{CREW_PREFIX}",
                 "--libdir=#{CREW_LIB_PREFIX}",
                 "--build=#{ARCH}-cros-linux-gnu",
                 "--host=#{ARCH}-cros-linux-gnu",
                 "--target=#{ARCH}-cros-linux-gnu",
                 "--enable-checking=release",
                 "--enable-languages=c,c++,fortran",
                 "--disable-multilib",
                 "--enable-threads=posix",
                 "--enable-bootstrap",
                 "--disable-libmpx",
                 "--disable-static",
                 "--program-suffix=-7.3",
                 "--with-arch-32=i686",
                 "--with-default-libstdcxx-abi=gcc4-compatible"
      end
      # Comment: --with-default-libstdcxx-abi=gcc-compatible
      #          Use this switch if we are upgrading from GCC version prior to 5.1.0
      #          We do not want to recompile all the libraries written in C++
      
        system "make"
    end
  end
  
  
  # preserve for check, skip check for current version
  def self.check
    Dir.chdir("objdir") do
      #system "ulimit -s 32768"
      #system "make -k check -j8"
      #system "../contrib/test_summary > ~/Downloads/gcc_test_summary.txt"
    end
  end
  
  def self.install
    Dir.chdir("objdir") do
	    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
	   
	    # http://www.linuxfromscratch.org/lfs/view/development/chapter06/gcc.html#contents-gcc
	    # move a misplaced file
	    # The installation stage puts some files used by gdb under the /usr/local/lib(64) directory. This generates spurious error messages when performing ldconfig. This command moves the files to another location.
      system "mkdir -pv #{CREW_DEST_PREFIX}/share/gdb/auto-load/usr/lib"
      system "mv -v #{CREW_DEST_LIB_PREFIX}/*gdb.py #{CREW_DEST_PREFIX}/share/gdb/auto-load/usr/lib"
	    
	    # Install Binary File Descriptor library (BFD)
	    system "install -v -dm755 #{CREW_DEST_LIB_PREFIX}/bfd-plugins"
    end
  end
    
  def self.postinstall
    
    #system "ln -sv gcc-7.3 #{CREW_PREFIX}/bin/gcc"
	  #system "ln -sv gcc-7.3 #{CREW_PREFIX}/bin/cc"
	  # Add a compatibility symlink to enable building programs with Link Time Optimization (LTO)
	  system "ln -sfv #{CREW_PREFIX}/libexec/gcc/$(gcc -dumpmachine)/7.3.0/liblto_plugin.so #{CREW_LIB_PREFIX}/bfd-plugins/"
  end
  
end

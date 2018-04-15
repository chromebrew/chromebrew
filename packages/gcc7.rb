require 'package'

class Gcc7 < Package
  description 'The GNU Compiler Collection includes front ends for C, C++, Objective-C, Fortran, Ada, and Go.'
  homepage 'https://www.gnu.org/software/gcc/'
  version '7.3.0-1'
  source_url 'https://github.com/gcc-mirror/gcc/archive/gcc-7_3_0-release.tar.gz'
  source_sha256 'af11c397296cab69996723b9d828c98a9bb749447ac8f7ed67458bcdb60311ed'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gcc7-7.3.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gcc7-7.3.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gcc7-7.3.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gcc7-7.3.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd72f4e2b4eca106dd378ea337ee6ee640fab0db0c19ef3392c0d9f93408c8071',
     armv7l: 'd72f4e2b4eca106dd378ea337ee6ee640fab0db0c19ef3392c0d9f93408c8071',
       i686: '6fd7621b2e713bdb378e0720f90c36aab9109c5bb74f3a35af97b07933128a7b',
     x86_64: '4f96ebe9f76b571fbec77ef9cdc03e9a2dafe27bd3a0461dd0a41ccdd555e6a2',
  })

  depends_on 'unzip' => :build
  depends_on 'gawk' => :build
  depends_on 'dejagnu' => :build # for test
  depends_on 'gcc' => :build   # gcc version 4.9.4
  depends_on 'icu4c' => :build # icu version 60.1
  depends_on 'python27' => :build
  depends_on 'python3' => :build
  
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
                 "--disable-bootstrap",
                 "--disable-werror",
                 "--disable-libmpx",
                 "--enable-static",
                 "--enable-shared",
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
                 "--disable-bootstrap",
                 "--disable-werror",
                 "--disable-libmpx",
                 "--enable-static",
                 "--enable-shared",
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
                 "--disable-bootstrap",
                 "--disable-werror",
                 "--disable-libmpx",
                 "--enable-static",
                 "--enable-shared",
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
      #system "../contrib/test_summary"
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
      
      # Add a compatibility symlink to enable building programs with Link Time Optimization (LTO)
      system "ln -sfv #{CREW_DEST_PREFIX}/libexec/gcc/$(gcc -dumpmachine)/7.3.0/liblto_plugin.so #{CREW_DEST_LIB_PREFIX}/bfd-plugins/"
      
      # Make symbolic links
      system "ln -sv #{CREW_DEST_PREFIX}/bin/gcc-7.3 #{CREW_DEST_PREFIX}/bin/cc"
      system "ln -sv #{CREW_DEST_PREFIX}/bin/gcc-7.3 #{CREW_DEST_PREFIX}/bin/gcc"
      system "ln -sv #{CREW_DEST_PREFIX}/bin/c++-7.3 #{CREW_DEST_PREFIX}/bin/c++"
      system "ln -sv #{CREW_DEST_PREFIX}/bin/g++-7.3 #{CREW_DEST_PREFIX}/bin/g++"
      system "ln -sv #{CREW_DEST_PREFIX}/bin/cpp-7.3 #{CREW_DEST_PREFIX}/bin/cpp"
      system "ln -sv #{CREW_DEST_PREFIX}/bin/gcc-ar-7.3 #{CREW_DEST_PREFIX}/bin/gcc-ar"
      system "ln -sv #{CREW_DEST_PREFIX}/bin/gcc-nm-7.3 #{CREW_DEST_PREFIX}/bin/gcc-nm"
      system "ln -sv #{CREW_DEST_PREFIX}/bin/gcc-ranlib-7.3 #{CREW_DEST_PREFIX}/bin/gcc-ranlib"
      system "ln -sv #{CREW_DEST_PREFIX}/bin/gcov-7.3 #{CREW_DEST_PREFIX}/bin/gcov"
      system "ln -sv #{CREW_DEST_PREFIX}/bin/gcov-dump-7.3 #{CREW_DEST_PREFIX}/bin/gcov-dump"
      system "ln -sv #{CREW_DEST_PREFIX}/bin/gcov-tool-7.3 #{CREW_DEST_PREFIX}/bin/gcov-tool"
      system "ln -sv #{CREW_DEST_PREFIX}/bin/gfortran-7.3 #{CREW_DEST_PREFIX}/bin/gfortran"
      
      system "ln -sv #{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-c++-7.3 #{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-c++"
      system "ln -sv #{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-g++-7.3 #{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-g++"
      system "ln -sv #{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-gcc-7.3 #{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-gcc"
      system "ln -sv #{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-gcc-ar-7.3 #{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-gcc-ar"
      system "ln -sv #{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-gcc-nm-7.3 #{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-gcc-nm"
      system "ln -sv #{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-gcc-ranlib-7.3 #{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-gcc-ranlib"
      system "ln -sv #{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-gfortran-7.3 #{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-gfortran"

    end
  end
end

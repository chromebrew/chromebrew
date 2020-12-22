require 'package'

class Gcc10 < Package
  description 'The GNU Compiler Collection includes front ends for C, C++, Objective-C, Fortran, Ada, and Go.'
  homepage 'https://www.gnu.org/software/gcc/'
  version '10.2.1-07fe'
  compatibility 'all'
  source_url 'https://github.com/gcc-mirror/gcc/archive/07fed10b19e1d88ad111fd27b4181e53d1aa6778.zip'
  source_sha256 '455b11e3e82118d8b026cb1a8cb0e7b8331f1f9d76551c60e6792d488b4f1f12'

  binary_url ({
     aarch64: 'file:///usr/local/tmp/packages/gcc10-10.2.1-07fe-chromeos-armv7l.tar.xz',
      armv7l: 'file:///usr/local/tmp/packages/gcc10-10.2.1-07fe-chromeos-armv7l.tar.xz',
        i686: 'file:///usr/local/tmp/packages/gcc10-10.2.1-07fe-chromeos-i686.tar.xz',
      x86_64: 'file:///usr/local/tmp/packages/gcc10-10.2.1-07fe-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'e5405c03363f2e1feff695da2c29320665698b41877bfc32bdb670b330d7099b',
      armv7l: 'e5405c03363f2e1feff695da2c29320665698b41877bfc32bdb670b330d7099b',
        i686: '8562773de8265d440a6b4de987676959dfd5c46a7153bb0c1cb24776ba500c03',
      x86_64: '40fe0391e7cb070e1f3fe7d140dcefdcb64cd6f3063784ae93aa309cce479bc4',
  })




  depends_on 'unzip' => :build
  depends_on 'gawk' => :build
  depends_on 'dejagnu' => :build # for test
  depends_on 'icu4c' => :build
  depends_on 'python27' => :build
  depends_on 'python3' => :build

  depends_on 'binutils'
  depends_on 'gmp'
  depends_on 'mpfr'
  depends_on 'mpc'
  depends_on 'isl'
  depends_on 'glibc'
  depends_on 'zstd'

  
  
  def self.preinstall
    installed_gccver = `gcc -v 2>&1 | tail -1 | cut -d' ' -f3`.chomp
    gcc_version = version.split("-")[0]
    abort "GCC version #{installed_gccver} already installed.".lightgreen unless "#{installed_gccver}" == "No" || "#{installed_gccver}" == "not" || "#{installed_gccver}" == "gcc:" || "#{installed_gccver}" == "#{gcc_version}"
  end

  def self.build
    gcc_version = version.split("-")[0]
    
    # previous compile issue
    # /usr/local/bin/ld: cannot find crti.o: No such file or directory
    # /usr/local/bin/ld: cannot find /usr/lib64/libc_nonshared.a
    ENV["LIBRARY_PATH"] = "#{CREW_LIB_PREFIX}"   # fix x86_64 issues
    system "mkdir -p objdir"
    system "mkdir -p objdir/gcc/.deps"
    # This fixes a PATH_MAX undefined error which breaks libsanitizer
    # "libsanitizer/asan/asan_linux.cpp:217:21: error: ‘PATH_MAX’ was not declared in this scope"
    # This is defined in https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads/chromeos-5.4/include/uapi/linux/limits.h
    # and is defined as per suggested method here: https://github.com/ZefengWang/cross-tool-chain-build
    # The following is due to sed not passing newlines right.
    system "grep  -q 4096 libsanitizer/asan/asan_linux.cpp || (sed -i '77a #endif' libsanitizer/asan/asan_linux.cpp &&
    sed -i '77a #define PATH_MAX 4096' libsanitizer/asan/asan_linux.cpp &&
    sed -i '77a #ifndef PATH_MAX' libsanitizer/asan/asan_linux.cpp)"
    Dir.chdir("objdir") do
      case ARCH
      when 'armv7l', 'armv8l', 'aarch64'
        system "../configure",
        "--prefix=#{CREW_PREFIX}",
        "--libdir=#{CREW_LIB_PREFIX}",
        "--build=armv7l-cros-linux-gnueabihf",
        "--host=armv7l-cros-linux-gnueabihf",
        "--target=armv7l-cros-linux-gnueabihf",
        "--enable-checking=release",
        "--disable-multilib",
        "--enable-lto",
        "--enable-threads=posix",
        "--disable-bootstrap",
        "--disable-werror",
        "--disable-libmpx",
        "--enable-static",
        "--enable-shared",
        "--program-suffix=-#{gcc_version}",
        "--with-arch=armv7-a",
        "--with-tune=cortex-a15",
        "--with-fpu=neon",
        "--with-float=hard"
      when 'x86_64'
        system "../configure",
        "--prefix=#{CREW_PREFIX}",
        "--libdir=#{CREW_LIB_PREFIX}",
        "--build=#{ARCH}-cros-linux-gnu",
        "--host=#{ARCH}-cros-linux-gnu",
        "--target=#{ARCH}-cros-linux-gnu",
        "--enable-checking=release",
        "--enable-lto",
        "--disable-multilib",
        "--enable-threads=posix",
        "--disable-bootstrap",
        "--disable-werror",
        "--disable-libmpx",
        "--enable-static",
        "--enable-shared",
        "--program-suffix=-#{gcc_version}",
        "--with-arch-64=x86-64"
      when 'i686'
        system "../configure",
        "--prefix=#{CREW_PREFIX}",
        "--libdir=#{CREW_LIB_PREFIX}",
        "--build=#{ARCH}-cros-linux-gnu",
        "--host=#{ARCH}-cros-linux-gnu",
        "--target=#{ARCH}-cros-linux-gnu",
        "--enable-checking=release",
        "--enable-lto",
        "--disable-multilib",
        "--enable-threads=posix",
        "--disable-bootstrap",
        "--disable-werror",
        "--disable-libmpx",
        "--enable-static",
        "--enable-shared",
        "--program-suffix=-#{gcc_version}",
        "--with-arch-32=i686"
      end
      system 'make'
    end
  end

  # preserve for check, skip check for current version
  def self.check
    Dir.chdir("objdir") do
      #system "make -k check -j#{CREW_NPROC}"
      #system "../contrib/test_summary"
    end
  end

  def self.install
    Dir.chdir("objdir") do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"

      gcc_arch = `gcc/xgcc -dumpmachine`.chomp
      gcc_version = version.split("-")[0]
      #gcc_version = `cat ../gcc/BASE-VER`
      #gcc_version = `gcc/xgcc -dumpversion`.chomp
      gcc_dir = "gcc/#{gcc_arch}/#{gcc_version}"
      gcc_libdir = "#{CREW_LIB_PREFIX}/#{gcc_dir}"

      # http://www.linuxfromscratch.org/lfs/view/development/chapter06/gcc.html#contents-gcc
      # move a misplaced file
      # The installation stage puts some files used by gdb under the /usr/local/lib(64) directory. This generates spurious error messages when performing ldconfig. This command moves the files to another location.
      system "mkdir -pv #{CREW_DEST_PREFIX}/share/gdb/auto-load/usr/lib"
      system "mv -v #{CREW_DEST_LIB_PREFIX}/*gdb.py #{CREW_DEST_PREFIX}/share/gdb/auto-load/usr/lib"

      # Install Binary File Descriptor library (BFD)
      system "install -v -dm755 #{CREW_DEST_LIB_PREFIX}/bfd-plugins"

      # Add a compatibility symlink to enable building programs with Link Time Optimization (LTO)
      system "ln -rsfv #{CREW_DEST_PREFIX}/libexec/#{gcc_dir}/liblto_plugin.so #{CREW_DEST_LIB_PREFIX}/bfd-plugins/"

      # Make symbolic links
      Dir.chdir "#{CREW_DEST_LIB_PREFIX}/#{gcc_dir}" do
        system "find . -type f -maxdepth 1 -exec ln -sv #{gcc_libdir}/{} #{CREW_DEST_LIB_PREFIX}/{} \\;"
      end

      system "ln -rsv #{CREW_DEST_PREFIX}/bin/gcc-#{gcc_version} #{CREW_DEST_PREFIX}/bin/cc"
      system "ln -rsv #{CREW_DEST_PREFIX}/bin/gcc-#{gcc_version} #{CREW_DEST_PREFIX}/bin/gcc"
      system "ln -rsv #{CREW_DEST_PREFIX}/bin/c++-#{gcc_version} #{CREW_DEST_PREFIX}/bin/c++"
      system "ln -rsv #{CREW_DEST_PREFIX}/bin/g++-#{gcc_version} #{CREW_DEST_PREFIX}/bin/g++"
      system "ln -rsv #{CREW_DEST_PREFIX}/bin/cpp-#{gcc_version} #{CREW_DEST_PREFIX}/bin/cpp"
      system "ln -rsv #{CREW_DEST_PREFIX}/bin/gcc-ar-#{gcc_version} #{CREW_DEST_PREFIX}/bin/gcc-ar"
      system "ln -rsv #{CREW_DEST_PREFIX}/bin/gcc-nm-#{gcc_version} #{CREW_DEST_PREFIX}/bin/gcc-nm"
      system "ln -rsv #{CREW_DEST_PREFIX}/bin/gcc-ranlib-#{gcc_version} #{CREW_DEST_PREFIX}/bin/gcc-ranlib"
      system "ln -rsv #{CREW_DEST_PREFIX}/bin/gcov-#{gcc_version} #{CREW_DEST_PREFIX}/bin/gcov"
      system "ln -rsv #{CREW_DEST_PREFIX}/bin/gcov-dump-#{gcc_version} #{CREW_DEST_PREFIX}/bin/gcov-dump"
      system "ln -rsv #{CREW_DEST_PREFIX}/bin/gcov-tool-#{gcc_version} #{CREW_DEST_PREFIX}/bin/gcov-tool"
      system "ln -rsv #{CREW_DEST_PREFIX}/bin/gfortran-#{gcc_version} #{CREW_DEST_PREFIX}/bin/gfortran"

      system "ln -rsv #{CREW_DEST_PREFIX}/bin/#{gcc_arch}-c++-#{gcc_version} #{CREW_DEST_PREFIX}/bin/#{gcc_arch}-c++"
      system "ln -rsv #{CREW_DEST_PREFIX}/bin/#{gcc_arch}-g++-#{gcc_version} #{CREW_DEST_PREFIX}/bin/#{gcc_arch}-g++"
      system "ln -rsv #{CREW_DEST_PREFIX}/bin/#{gcc_arch}-gcc-#{gcc_version} #{CREW_DEST_PREFIX}/bin/#{gcc_arch}-gcc"
      system "ln -rsv #{CREW_DEST_PREFIX}/bin/#{gcc_arch}-gcc-ar-#{gcc_version} #{CREW_DEST_PREFIX}/bin/#{gcc_arch}-gcc-ar"
      system "ln -rsv #{CREW_DEST_PREFIX}/bin/#{gcc_arch}-gcc-nm-#{gcc_version} #{CREW_DEST_PREFIX}/bin/#{gcc_arch}-gcc-nm"
      system "ln -rsv #{CREW_DEST_PREFIX}/bin/#{gcc_arch}-gcc-ranlib-#{gcc_version} #{CREW_DEST_PREFIX}/bin/#{gcc_arch}-gcc-ranlib"
      system "ln -rsv #{CREW_DEST_PREFIX}/bin/#{gcc_arch}-gfortran-#{gcc_version} #{CREW_DEST_PREFIX}/bin/#{gcc_arch}-gfortran"

      system "ln -rsv #{CREW_DEST_PREFIX}/share/man/man1/cpp-#{gcc_version}.1.gz #{CREW_DEST_PREFIX}/share/man/man1/cpp.1.gz"
      system "ln -rsv #{CREW_DEST_PREFIX}/share/man/man1/g++-#{gcc_version}.1.gz #{CREW_DEST_PREFIX}/share/man/man1/g++.1.gz"
      system "ln -rsv #{CREW_DEST_PREFIX}/share/man/man1/gcc-#{gcc_version}.1.gz #{CREW_DEST_PREFIX}/share/man/man1/gcc.1.gz"
      system "ln -rsv #{CREW_DEST_PREFIX}/share/man/man1/gcov-#{gcc_version}.1.gz #{CREW_DEST_PREFIX}/share/man/man1/gcov.1.gz"
      system "ln -rsv #{CREW_DEST_PREFIX}/share/man/man1/gcov-dump-#{gcc_version}.1.gz #{CREW_DEST_PREFIX}/share/man/man1/gcov-dump.1.gz"
      system "ln -rsv #{CREW_DEST_PREFIX}/share/man/man1/gcov-tool-#{gcc_version}.1.gz #{CREW_DEST_PREFIX}/share/man/man1/gcov-tool.1.gz"
      system "ln -rsv #{CREW_DEST_PREFIX}/share/man/man1/gfortran-#{gcc_version}.1.gz #{CREW_DEST_PREFIX}/share/man/man1/gfortran.1.gz"
    end
  end
end

require 'package'

class Gcc10 < Package
  description 'The GNU Compiler Collection includes front ends for C, C++, Objective-C, Fortran, Ada, and Go.'
  homepage 'https://www.gnu.org/software/gcc/'
  version '10.2.0'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gcc/gcc-10.2.0/gcc-10.2.0.tar.xz'
  source_sha256 'b8dd4368bb9c7f0b98188317ee0254dd8cc99d1e3a18d0ff146c855fe16c1d8c'


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
    gccver = `gcc -v 2>&1 | tail -1 | cut -d' ' -f3`.chomp
    abort "GCC version #{gccver} already installed.".lightgreen unless "#{gccver}" == "No" || "#{gccver}" == "not" || "#{gccver}" == "gcc:" || "#{gccver}" == "#{version}"
  end


  def self.build
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
      when 'armv7l', 'aarch64'
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
        "--disable-werror",
        "--disable-libmpx",
        "--enable-static",
        "--enable-shared",
        "--program-suffix=-#{version}",
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
        "--disable-werror",
        "--disable-libmpx",
        "--enable-static",
        "--enable-shared",
        "--program-suffix=-#{version}",
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
        "--disable-werror",
        "--disable-libmpx",
        "--enable-static",
        "--enable-shared",
        "--program-suffix=-#{version}",
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

      gcc_arch = `gcc -dumpmachine`.chomp
      gcc_dir = "gcc/#{gcc_arch}/#{version}"
      gcc_libdir = "#{CREW_LIB_PREFIX}/#{gcc_dir}"

      # http://www.linuxfromscratch.org/lfs/view/development/chapter06/gcc.html#contents-gcc
      # move a misplaced file
      # The installation stage puts some files used by gdb under the /usr/local/lib(64) directory. This generates spurious error messages when performing ldconfig. This command moves the files to another location.
      system "mkdir -pv #{CREW_DEST_PREFIX}/share/gdb/auto-load/usr/lib"
      system "mv -v #{CREW_DEST_LIB_PREFIX}/*gdb.py #{CREW_DEST_PREFIX}/share/gdb/auto-load/usr/lib"

      # Install Binary File Descriptor library (BFD)
      system "install -v -dm755 #{CREW_DEST_LIB_PREFIX}/bfd-plugins"

      # Add a compatibility symlink to enable building programs with Link Time Optimization (LTO)
      system "ln -sfv #{CREW_PREFIX}/libexec/#{gcc_dir}/liblto_plugin.so #{CREW_DEST_LIB_PREFIX}/bfd-plugins/"

      # Make symbolic links
      Dir.chdir "#{CREW_DEST_LIB_PREFIX}/#{gcc_dir}" do
        system "find . -type f -maxdepth 1 -exec ln -sv #{gcc_libdir}/{} #{CREW_DEST_LIB_PREFIX}/{} \\;"
      end

      system "ln -sv #{CREW_PREFIX}/bin/gcc-#{version} #{CREW_DEST_PREFIX}/bin/cc"
      system "ln -sv #{CREW_PREFIX}/bin/gcc-#{version} #{CREW_DEST_PREFIX}/bin/gcc"
      system "ln -sv #{CREW_PREFIX}/bin/c++-#{version} #{CREW_DEST_PREFIX}/bin/c++"
      system "ln -sv #{CREW_PREFIX}/bin/g++-#{version} #{CREW_DEST_PREFIX}/bin/g++"
      system "ln -sv #{CREW_PREFIX}/bin/cpp-#{version} #{CREW_DEST_PREFIX}/bin/cpp"
      system "ln -sv #{CREW_PREFIX}/bin/gcc-ar-#{version} #{CREW_DEST_PREFIX}/bin/gcc-ar"
      system "ln -sv #{CREW_PREFIX}/bin/gcc-nm-#{version} #{CREW_DEST_PREFIX}/bin/gcc-nm"
      system "ln -sv #{CREW_PREFIX}/bin/gcc-ranlib-#{version} #{CREW_DEST_PREFIX}/bin/gcc-ranlib"
      system "ln -sv #{CREW_PREFIX}/bin/gcov-#{version} #{CREW_DEST_PREFIX}/bin/gcov"
      system "ln -sv #{CREW_PREFIX}/bin/gcov-dump-#{version} #{CREW_DEST_PREFIX}/bin/gcov-dump"
      system "ln -sv #{CREW_PREFIX}/bin/gcov-tool-#{version} #{CREW_DEST_PREFIX}/bin/gcov-tool"
      system "ln -sv #{CREW_PREFIX}/bin/gfortran-#{version} #{CREW_DEST_PREFIX}/bin/gfortran"

      system "ln -sv #{CREW_PREFIX}/bin/#{gcc_arch}-c++-#{version} #{CREW_DEST_PREFIX}/bin/#{gcc_arch}-c++"
      system "ln -sv #{CREW_PREFIX}/bin/#{gcc_arch}-g++-#{version} #{CREW_DEST_PREFIX}/bin/#{gcc_arch}-g++"
      system "ln -sv #{CREW_PREFIX}/bin/#{gcc_arch}-gcc-#{version} #{CREW_DEST_PREFIX}/bin/#{gcc_arch}-gcc"
      system "ln -sv #{CREW_PREFIX}/bin/#{gcc_arch}-gcc-ar-#{version} #{CREW_DEST_PREFIX}/bin/#{gcc_arch}-gcc-ar"
      system "ln -sv #{CREW_PREFIX}/bin/#{gcc_arch}-gcc-nm-#{version} #{CREW_DEST_PREFIX}/bin/#{gcc_arch}-gcc-nm"
      system "ln -sv #{CREW_PREFIX}/bin/#{gcc_arch}-gcc-ranlib-#{version} #{CREW_DEST_PREFIX}/bin/#{gcc_arch}-gcc-ranlib"
      system "ln -sv #{CREW_PREFIX}/bin/#{gcc_arch}-gfortran-#{version} #{CREW_DEST_PREFIX}/bin/#{gcc_arch}-gfortran"

      system "ln -sv #{CREW_PREFIX}/share/man/man1/cpp-#{version}.1.gz #{CREW_DEST_PREFIX}/share/man/man1/cpp.1.gz"
      system "ln -sv #{CREW_PREFIX}/share/man/man1/g++-#{version}.1.gz #{CREW_DEST_PREFIX}/share/man/man1/g++.1.gz"
      system "ln -sv #{CREW_PREFIX}/share/man/man1/gcc-#{version}.1.gz #{CREW_DEST_PREFIX}/share/man/man1/gcc.1.gz"
      system "ln -sv #{CREW_PREFIX}/share/man/man1/gcov-#{version}.1.gz #{CREW_DEST_PREFIX}/share/man/man1/gcov.1.gz"
      system "ln -sv #{CREW_PREFIX}/share/man/man1/gcov-dump-#{version}.1.gz #{CREW_DEST_PREFIX}/share/man/man1/gcov-dump.1.gz"
      system "ln -sv #{CREW_PREFIX}/share/man/man1/gcov-tool-#{version}.1.gz #{CREW_DEST_PREFIX}/share/man/man1/gcov-tool.1.gz"
      system "ln -sv #{CREW_PREFIX}/share/man/man1/gfortran-#{version}.1.gz #{CREW_DEST_PREFIX}/share/man/man1/gfortran.1.gz"
    end
  end
end

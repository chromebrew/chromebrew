require 'package'

class Gcc10 < Package
  description 'The GNU Compiler Collection includes front ends for C, C++, Objective-C, Fortran, Ada, and Go.'
  homepage 'https://www.gnu.org/software/gcc/'
  version '10.2.1-e73c'
  compatibility 'all'
  source_url 'https://github.com/gcc-mirror/gcc/archive/e73caa0fc12e4b33563d68ee58b8af882b2341e6.zip'
  source_sha256 '61b3e87c52e232c0e6c07b054c215d6c5bda09b910655b00080fa7cc634a436f'

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
    FileUtils.mkdir_p "objdir/gcc/.deps"
    # This fixes a PATH_MAX undefined error which breaks libsanitizer
    # "libsanitizer/asan/asan_linux.cpp:217:21: error: ‘PATH_MAX’ was not declared in this scope"
    # This is defined in https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads/chromeos-5.4/include/uapi/linux/limits.h
    # and is defined as per suggested method here: https://github.com/ZefengWang/cross-tool-chain-build
    # The following is due to sed not passing newlines right.
    system "grep  -q 4096 libsanitizer/asan/asan_linux.cpp || (sed -i '77a #endif' libsanitizer/asan/asan_linux.cpp &&
    sed -i '77a #define PATH_MAX 4096' libsanitizer/asan/asan_linux.cpp &&
    sed -i '77a #ifndef PATH_MAX' libsanitizer/asan/asan_linux.cpp)"
    # Fix "crtbeginT.o: relocation R_X86_64_32 against hidden symbol `__TMC_END__' can not be used when making a shared object"
    # when building static llvm
    system "sed -i 's/-fbuilding-libgcc -fno-stack-protector/-fbuilding-libgcc -fPIC -fno-stack-protector/g' libgcc/Makefile.in"
    Dir.chdir("objdir") do
      ENV['CFLAGS'] = '-fPIC'
      ENV['CXXFLAGS'] = '-fPIC'
      case ARCH
      when 'armv7l', 'aarch64'
        system "../configure #{CREW_OPTIONS} \
        --enable-checking=release \
        --disable-multilib \
        --enable-lto \
        --enable-threads=posix \
        --disable-bootstrap \
        --disable-werror \
        --disable-libmpx \
        --enable-static \
        --enable-shared \
        --with-pic \
        --program-suffix=-#{gcc_version} \
        --with-arch=armv7-a \
        --with-tune=cortex-a15 \
        --with-fpu=neon \
        --with-float=hard"
      when 'x86_64'
        system "../configure  #{CREW_OPTIONS} \
        --enable-checking=release \
        --enable-lto \
        --disable-multilib \
        --enable-threads=posix \
        --disable-bootstrap \
        --disable-werror \
        --disable-libmpx \
        --enable-static \
        --enable-shared \
        --with-pic \
        --program-suffix=-#{gcc_version} \
        --with-arch-64=x86-64"
      when 'i686'
        system "../configure  #{CREW_OPTIONS} \
        --enable-checking=release \
        --enable-lto \
        --disable-multilib \
        --enable-threads=posix \
        --disable-bootstrap \
        --disable-werror \
        --disable-libmpx \
        --enable-static \
        --enable-shared \
        --with-pic \
        --program-suffix=-#{gcc_version} \
        --with-arch-32=#{ARCH}"
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
      FileUtils.mkdir_p  "#{CREW_DEST_PREFIX}/share/gdb/auto-load/usr/lib"
      FileUtils.mv Dir.glob("#{CREW_DEST_LIB_PREFIX}/*gdb.py"), "#{CREW_DEST_PREFIX}/share/gdb/auto-load/usr/lib/"

      # Install Binary File Descriptor library (BFD)
      system "install -v -dm755 #{CREW_DEST_LIB_PREFIX}/bfd-plugins"

      # Add a compatibility symlink to enable building programs with Link Time Optimization (LTO)
      FileUtils.ln_s "#{CREW_PREFIX}/libexec/#{gcc_dir}/liblto_plugin.so", "#{CREW_DEST_LIB_PREFIX}/bfd-plugins/"

      # Make symbolic links
      Dir.chdir "#{CREW_DEST_LIB_PREFIX}/#{gcc_dir}" do
        system "find . -type f -maxdepth 1 -exec ln -sv #{gcc_libdir}/{} #{CREW_DEST_LIB_PREFIX}/{} \\;"
      end

      FileUtils.ln_s "#{CREW_PREFIX}/bin/gcc-#{gcc_version}", "#{CREW_DEST_PREFIX}/bin/cc"
      FileUtils.ln_s "#{CREW_PREFIX}/bin/gcc-#{gcc_version}", "#{CREW_DEST_PREFIX}/bin/gcc"
      FileUtils.ln_s "#{CREW_PREFIX}/bin/c++-#{gcc_version}", "#{CREW_DEST_PREFIX}/bin/c++"
      FileUtils.ln_s "#{CREW_PREFIX}/bin/g++-#{gcc_version}", "#{CREW_DEST_PREFIX}/bin/g++"
      FileUtils.ln_s "#{CREW_PREFIX}/bin/cpp-#{gcc_version}", "#{CREW_DEST_PREFIX}/bin/cpp"
      FileUtils.ln_s "#{CREW_PREFIX}/bin/gcc-ar-#{gcc_version}", "#{CREW_DEST_PREFIX}/bin/gcc-ar"
      FileUtils.ln_s "#{CREW_PREFIX}/bin/gcc-nm-#{gcc_version}", "#{CREW_DEST_PREFIX}/bin/gcc-nm"
      FileUtils.ln_s "#{CREW_PREFIX}/bin/gcc-ranlib-#{gcc_version}", "#{CREW_DEST_PREFIX}/bin/gcc-ranlib"
      FileUtils.ln_s "#{CREW_PREFIX}/bin/gcov-#{gcc_version}", "#{CREW_DEST_PREFIX}/bin/gcov"
      FileUtils.ln_s "#{CREW_PREFIX}/bin/gcov-dump-#{gcc_version}", "#{CREW_DEST_PREFIX}/bin/gcov-dump"
      FileUtils.ln_s "#{CREW_PREFIX}/bin/gcov-tool-#{gcc_version}", "#{CREW_DEST_PREFIX}/bin/gcov-tool"
      FileUtils.ln_s "#{CREW_PREFIX}/bin/gfortran-#{gcc_version}", "#{CREW_DEST_PREFIX}/bin/gfortran"

      FileUtils.ln_s "#{CREW_PREFIX}/bin/#{gcc_arch}-c++-#{gcc_version}", "#{CREW_DEST_PREFIX}/bin/#{gcc_arch}-c++"
      FileUtils.ln_s "#{CREW_PREFIX}/bin/#{gcc_arch}-g++-#{gcc_version}", "#{CREW_DEST_PREFIX}/bin/#{gcc_arch}-g++"
      FileUtils.ln_s "#{CREW_PREFIX}/bin/#{gcc_arch}-gcc-#{gcc_version}", "#{CREW_DEST_PREFIX}/bin/#{gcc_arch}-gcc"
      FileUtils.ln_s "#{CREW_PREFIX}/bin/#{gcc_arch}-gcc-ar-#{gcc_version}", "#{CREW_DEST_PREFIX}/bin/#{gcc_arch}-gcc-ar"

      FileUtils.ln_s "#{CREW_PREFIX}/bin/#{gcc_arch}-gcc-nm-#{gcc_version}", "#{CREW_DEST_PREFIX}/bin/#{gcc_arch}-gcc-nm"
      FileUtils.ln_s "#{CREW_PREFIX}/bin/#{gcc_arch}-gcc-ranlib-#{gcc_version}", "#{CREW_DEST_PREFIX}/bin/#{gcc_arch}-gcc-ranlib"
      FileUtils.ln_s "#{CREW_PREFIX}/bin/#{gcc_arch}-gfortran-#{gcc_version}", "#{CREW_DEST_PREFIX}/bin/#{gcc_arch}-gfortran"
      
      FileUtils.ln_s "#{CREW_PREFIX}/bin/gcc-ar-#{gcc_version}", "#{CREW_DEST_PREFIX}/bin/#{gcc_arch}-ar"
      FileUtils.ln_s "#{CREW_PREFIX}/bin/gcc-nm-#{gcc_version}", "#{CREW_DEST_PREFIX}/bin/#{gcc_arch}-nm"
      FileUtils.ln_s "#{CREW_PREFIX}/bin/gcc-ranlib-#{gcc_version}", "#{CREW_DEST_PREFIX}/bin/#{gcc_arch}-ranlib"


      FileUtils.ln_s "#{CREW_PREFIX}/share/man/man1/cpp-#{gcc_version}.1.gz", "#{CREW_DEST_PREFIX}/share/man/man1/cpp.1.gz"
      FileUtils.ln_s "#{CREW_PREFIX}/share/man/man1/g++-#{gcc_version}.1.gz", "#{CREW_DEST_PREFIX}/share/man/man1/g++.1.gz"
      FileUtils.ln_s "#{CREW_PREFIX}/share/man/man1/gcc-#{gcc_version}.1.gz", "#{CREW_DEST_PREFIX}/share/man/man1/gcc.1.gz"
      FileUtils.ln_s "#{CREW_PREFIX}/share/man/man1/gcov-#{gcc_version}.1.gz", "#{CREW_DEST_PREFIX}/share/man/man1/gcov.1.gz"
      FileUtils.ln_s "#{CREW_PREFIX}/share/man/man1/gcov-dump-#{gcc_version}.1.gz", "#{CREW_DEST_PREFIX}/share/man/man1/gcov-dump.1.gz"
      FileUtils.ln_s "#{CREW_PREFIX}/share/man/man1/gcov-tool-#{gcc_version}.1.gz", "#{CREW_DEST_PREFIX}/share/man/man1/gcov-tool.1.gz"
      FileUtils.ln_s "#{CREW_PREFIX}/share/man/man1/gfortran-#{gcc_version}.1.gz", "#{CREW_DEST_PREFIX}/share/man/man1/gfortran.1.gz"
    end
  end
end

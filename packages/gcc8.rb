require 'package'

class Gcc8 < Package
  description 'The GNU Compiler Collection includes front ends for C, C++, Objective-C, Fortran, Ada, and Go.'
  homepage 'https://www.gnu.org/software/gcc/'
  version '8.2.0'
  source_url 'https://ftpmirror.gnu.org/gcc/gcc-8.2.0/gcc-8.2.0.tar.xz'
  source_sha256 '196c3c04ba2613f893283977e6011b2345d1cd1af9abeac58e916b1aab3e0080'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gcc8-8.2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gcc8-8.2.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gcc8-8.2.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gcc8-8.2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '536323fc5dd35e53665a19e65c636f288153efe4cdf31617c32103c64593b285',
     armv7l: '536323fc5dd35e53665a19e65c636f288153efe4cdf31617c32103c64593b285',
       i686: 'e37ca8d49198beaa9ba582fc25fa598ab3cd5ed7e46f96a03176fb9002cc6f7b',
     x86_64: '6d982f3c35acd3a738e176a3f3b8c4ea093c7be86882153a7711841cf0c80737',
  })

  depends_on 'unzip' => :build
  depends_on 'gawk' => :build
  depends_on 'dejagnu' => :build # for test
  depends_on 'gcc7' => :build # gcc version 7.4.0
  depends_on 'icu4c' => :build # icu version 62.1
  depends_on 'python27' => :build
  depends_on 'python3' => :build

  depends_on 'binutils'
  depends_on 'gmp'
  depends_on 'mpfr'
  depends_on 'mpc'
  depends_on 'isl'
  depends_on 'cloog'
  depends_on 'glibc'

  def self.patch
    # See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=86724#c4.
    system "sed -i '40i#include <isl/id.h>' gcc/graphite.h"
    system "sed -i '41i#include <isl/space.h>' gcc/graphite.h"
  end

  def self.build
    # previous compile issue
    # /usr/local/bin/ld: cannot find crti.o: No such file or directory
    # /usr/local/bin/ld: cannot find /usr/lib64/libc_nonshared.a
    ENV["LIBRARY_PATH"] = "#{CREW_LIB_PREFIX}"   # fix x86_64 issues
    system "mkdir -p objdir"
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
                 "--enable-threads=posix",
                 "--disable-bootstrap",
                 "--disable-werror",
                 "--disable-libmpx",
                 "--enable-static",
                 "--enable-shared",
                 "--program-suffix=-8.2",
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
                 "--disable-multilib",
                 "--enable-threads=posix",
                 "--disable-bootstrap",
                 "--disable-werror",
                 "--disable-libmpx",
                 "--enable-static",
                 "--enable-shared",
                 "--program-suffix=-8.2",
                 "--with-arch-64=x86-64"
        when 'i686'
          system "../configure",
                 "--prefix=#{CREW_PREFIX}",
                 "--libdir=#{CREW_LIB_PREFIX}",
                 "--build=#{ARCH}-cros-linux-gnu",
                 "--host=#{ARCH}-cros-linux-gnu",
                 "--target=#{ARCH}-cros-linux-gnu",
                 "--enable-checking=release",
                 "--disable-multilib",
                 "--enable-threads=posix",
                 "--disable-bootstrap",
                 "--disable-werror",
                 "--disable-libmpx",
                 "--enable-static",
                 "--enable-shared",
                 "--program-suffix=-8.2",
                 "--with-arch-32=i686"
      end
      system 'make'
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
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"

      # http://www.linuxfromscratch.org/lfs/view/development/chapter06/gcc.html#contents-gcc
      # move a misplaced file
      # The installation stage puts some files used by gdb under the /usr/local/lib(64) directory. This generates spurious error messages when performing ldconfig. This command moves the files to another location.
      system "mkdir -pv #{CREW_DEST_PREFIX}/share/gdb/auto-load/usr/lib"
      system "mv -v #{CREW_DEST_LIB_PREFIX}/*gdb.py #{CREW_DEST_PREFIX}/share/gdb/auto-load/usr/lib"

      # Install Binary File Descriptor library (BFD)
      system "install -v -dm755 #{CREW_DEST_LIB_PREFIX}/bfd-plugins"

      # Add a compatibility symlink to enable building programs with Link Time Optimization (LTO)
      system "ln -sfv #{CREW_PREFIX}/libexec/gcc/$(gcc -dumpmachine)/8.2.0/liblto_plugin.so #{CREW_DEST_LIB_PREFIX}/bfd-plugins/"

      # Make symbolic links
      system "ln -sv #{CREW_PREFIX}/bin/gcc-8.2 #{CREW_DEST_PREFIX}/bin/cc"
      system "ln -sv #{CREW_PREFIX}/bin/gcc-8.2 #{CREW_DEST_PREFIX}/bin/gcc"
      system "ln -sv #{CREW_PREFIX}/bin/c++-8.2 #{CREW_DEST_PREFIX}/bin/c++"
      system "ln -sv #{CREW_PREFIX}/bin/g++-8.2 #{CREW_DEST_PREFIX}/bin/g++"
      system "ln -sv #{CREW_PREFIX}/bin/cpp-8.2 #{CREW_DEST_PREFIX}/bin/cpp"
      system "ln -sv #{CREW_PREFIX}/bin/gcc-ar-8.2 #{CREW_DEST_PREFIX}/bin/gcc-ar"
      system "ln -sv #{CREW_PREFIX}/bin/gcc-nm-8.2 #{CREW_DEST_PREFIX}/bin/gcc-nm"
      system "ln -sv #{CREW_PREFIX}/bin/gcc-ranlib-8.2 #{CREW_DEST_PREFIX}/bin/gcc-ranlib"
      system "ln -sv #{CREW_PREFIX}/bin/gcov-8.2 #{CREW_DEST_PREFIX}/bin/gcov"
      system "ln -sv #{CREW_PREFIX}/bin/gcov-dump-8.2 #{CREW_DEST_PREFIX}/bin/gcov-dump"
      system "ln -sv #{CREW_PREFIX}/bin/gcov-tool-8.2 #{CREW_DEST_PREFIX}/bin/gcov-tool"
      system "ln -sv #{CREW_PREFIX}/bin/gfortran-8.2 #{CREW_DEST_PREFIX}/bin/gfortran"

      system "ln -sv #{CREW_PREFIX}/bin/$(gcc -dumpmachine)-c++-8.2 #{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-c++"
      system "ln -sv #{CREW_PREFIX}/bin/$(gcc -dumpmachine)-g++-8.2 #{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-g++"
      system "ln -sv #{CREW_PREFIX}/bin/$(gcc -dumpmachine)-gcc-8.2 #{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-gcc"
      system "ln -sv #{CREW_PREFIX}/bin/$(gcc -dumpmachine)-gcc-ar-8.2 #{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-gcc-ar"
      system "ln -sv #{CREW_PREFIX}/bin/$(gcc -dumpmachine)-gcc-nm-8.2 #{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-gcc-nm"
      system "ln -sv #{CREW_PREFIX}/bin/$(gcc -dumpmachine)-gcc-ranlib-8.2 #{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-gcc-ranlib"
      system "ln -sv #{CREW_PREFIX}/bin/$(gcc -dumpmachine)-gfortran-8.2 #{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-gfortran"
    end
  end
end

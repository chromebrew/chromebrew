require 'package'

class Gcc8 < Package
  description 'The GNU Compiler Collection includes front ends for C, C++, Objective-C, Fortran, Ada, and Go.'
  homepage 'https://www.gnu.org/software/gcc/'
  version '8.2.0-1'
  source_url 'https://ftpmirror.gnu.org/gcc/gcc-8.2.0/gcc-8.2.0.tar.xz'
  source_sha256 '196c3c04ba2613f893283977e6011b2345d1cd1af9abeac58e916b1aab3e0080'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'dejagnu' => :build # for test
  depends_on 'python27' => :build
  depends_on 'python3' => :build

  depends_on 'binutils'
  depends_on 'gmp'
  depends_on 'mpfr'
  depends_on 'mpc'
  depends_on 'isl'
  depends_on 'glibc'

  def self.patch
    # See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=86724#c4.
    system "sed -i '40i#include <isl/id.h>' gcc/graphite.h"
    system "sed -i '41i#include <isl/space.h>' gcc/graphite.h"
  end

  def self.build
    ENV['LIBRARY_PATH'] = CREW_LIB_PREFIX   # fix x86_64 issues
    FileUtils.mkdir('build')
    Dir.chdir('build') do
      case ARCH
        when 'armv7l', 'aarch64'
          system '../configure',
                 '--target=armv7l-cros-linux-gnueabihf',
                 '--build=armv7l-cros-linux-gnueabihf',
                 '--host=armv7l-cros-linux-gnueabihf',
                 "--libdir=#{CREW_LIB_PREFIX}",
                 '--enable-checking=release',
                 "--prefix=#{CREW_PREFIX}",
                 '--enable-languages=all',
                 '--enable-threads=posix',
                 '--with-tune=cortex-a15',
                 "--program-suffix=-#{version}",
                 '--with-arch=armv7-a',
                 '--with-float=hard',
                 '--disable-libmpx',
                 '--enable-static',
                 '--enable-shared',
                 '--with-fpu=neon'
        when 'x86_64', 'i686'
          system '../configure',
                 "--target=#{ARCH}-cros-linux-gnu",
                 "--build=#{ARCH}-cros-linux-gnu",
                 "--host=#{ARCH}-cros-linux-gnu",
                 "--libdir=#{CREW_LIB_PREFIX}",
                 '--enable-checking=release',
                 "--prefix=#{CREW_PREFIX}",
                 '--enable-languages=all',
                 '--enable-threads=posix',
                 "--program-suffix=-#{version}",
                 '--with-arch-64=x86-64',
                 '--with-arch-32=i686',
                 '--disable-multilib',
                 '--disable-libmpx',
                 '--enable-static',
                 '--enable-shared'
      end
      system 'make'
    end
  end

  # preserve for check, skip check for current version
  def self.check
    Dir.chdir('build') do
      system 'make -k check'
      system '../contrib/test_summary'
    end
  end

  def self.install
    Dir.chdir('build') do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-strip'

      FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/share/gdb/auto-load/#{CREW_LIB_PREFIX}")
      FileUtils.mv(Dir.glob("#{CREW_DEST_LIB_PREFIX}/*gdb.py"), "#{CREW_DEST_PREFIX}/share/gdb/auto-load/#{CREW_LIB_PREFIX}")

      FileUtils.mkdir_p("#{CREW_DEST_LIB_PREFIX}/bfd-plugins")

      # Add a compatibility symlink to enable building programs with Link Time Optimization (LTO)
      FileUtils.ln_s("../../libexec/gcc/$(gcc -dumpmachine)/8.2.0/liblto_plugin.so", "#{CREW_DEST_LIB_PREFIX}/bfd-plugins/")

      # Make symbolic links
      FileUtils.ln_s('gcc', "#{CREW_DEST_PREFIX}/bin/cc")
      FileUtils.ln_s("gcc-#{version}", "#{CREW_DEST_PREFIX}/bin/gcc")
      FileUtils.ln_s("c++-#{version}", "#{CREW_DEST_PREFIX}/bin/c++")
      FileUtils.ln_s("g++-#{version}", "#{CREW_DEST_PREFIX}/bin/g++")
      FileUtils.ln_s("cpp-#{version}", "#{CREW_DEST_PREFIX}/bin/cpp")
      FileUtils.ln_s("gcc-ar-#{version}", "#{CREW_DEST_PREFIX}/bin/gcc-ar")
      FileUtils.ln_s("gcc-nm-#{version}", "#{CREW_DEST_PREFIX}/bin/gcc-nm")
      FileUtils.ln_s("gcc-ranlib-#{version}", "#{CREW_DEST_PREFIX}/bin/gcc-ranlib")
      FileUtils.ln_s("gcov-#{version}", "#{CREW_DEST_PREFIX}/bin/gcov")
      FileUtils.ln_s("gcov-dump-#{version}", "#{CREW_DEST_PREFIX}/bin/gcov-dump")
      FileUtils.ln_s("gcov-tool-#{version}", "#{CREW_DEST_PREFIX}/bin/gcov-tool")
      FileUtils.ln_s("gfortran-#{version}", "#{CREW_DEST_PREFIX}/bin/gfortran")

      FileUtils.ln_s("$(gcc -dumpmachine)-c++-#{version}", "#{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-c++")
      FileUtils.ln_s("$(gcc -dumpmachine)-g++-#{version}", "#{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-g++")
      FileUtils.ln_s("$(gcc -dumpmachine)-gcc-#{version}", "#{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-gcc")
      FileUtils.ln_s("$(gcc -dumpmachine)-gcc-ar-#{version}", "#{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-gcc-ar")
      FileUtils.ln_s("$(gcc -dumpmachine)-gcc-nm-#{version}", "#{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-gcc-nm")
      FileUtils.ln_s("$(gcc -dumpmachine)-gcc-ranlib-#{version}", "#{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-gcc-ranlib")
      FileUtils.ln_s("$(gcc -dumpmachine)-gfortran-#{version}", "#{CREW_DEST_PREFIX}/bin/$(gcc -dumpmachine)-gfortran")
    end
  end
end

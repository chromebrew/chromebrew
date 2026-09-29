# Adapted from Arch Linux gdb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/gdb/trunk/PKGBUILD

require 'buildsystems/autotools'

class Gdb < Autotools
  description 'The GNU Debugger'
  homepage 'https://www.gnu.org/software/gdb/'
  version "18.1-#{CREW_GCC_VER}-#{CREW_PY_VER}"
  license 'GPL3'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/gdb/gdb-#{version.split('-').first}.tar.xz"
  source_sha256 'cd9fc3fe2b47743840e42c1592d3d87f8302eb18639c0b8b4ba0898002e2348f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '434e750e950deaec9d9022b840219c8e6a363cb358ae5c730d04f6ecf21fdb41',
     armv7l: '434e750e950deaec9d9022b840219c8e6a363cb358ae5c730d04f6ecf21fdb41',
       i686: '1a58785d717411524b4eac0d1515e9990c771c04f2e80aa70f1706bf45b0c360',
     x86_64: 'a961b15899fba5e78b1e59cdbf4547dafd6ea58ebf64f4efec07a693ad660d16'
  })

  depends_on 'binutils' => :executable
  depends_on 'binutils' => :library
  depends_on 'boost' => :executable
  depends_on 'elfutils' # R
  depends_on 'expat' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :executable
  depends_on 'mpfr' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'python3' => :executable
  depends_on 'readline' => :executable
  depends_on 'source_highlight' => :executable
  depends_on 'texinfo' => :build
  depends_on 'xxhash' => :executable
  depends_on 'xzutils' => :executable
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  autotools_skip_autoreconf
  conflicts_ok # binutils conflicts

  autotools_configure_options "--disable-binutils \
      --disable-ld \
      --disable-nls \
      --enable-64-bit-bfd \
      --enable-install-libbfd \
      --enable-host-shared \
      --enable-lto \
      --enable-shared \
      --enable-sim \
      --enable-source-highlight \
      --enable-tui \
      --with-curses \
      --with-lzma \
      --with-pkgversion=Chromebrew \
      --with-python=python3 \
      --with-system-gdbinit=#{CREW_PREFIX}/etc/gdb/gdbinit \
      --with-system-readline \
      --with-system-zlib \
      #{'--with-x' unless ARCH == 'i686'}"

  def self.patch
    patches = [
      # Fixes i686 build on older glibc.
      ['https://inbox.sourceware.org/gdb-patches/20260928172119.425553-1-simon.marchi@efficios.com/raw', '98ef611ff73ca43544a5331a7ca86c8ddf78e28efca9a95b832fe4f9e2b58949']
    ]
    ConvenienceFunctions.patch(patches) if ARCH == 'i686' && version.split('-').first == '18.1'
  end

  def self.prebuild
    # The c11threads threads.h breaks builds on software that uses gnulib.
    # See: https://github.com/jtsiomb/c11threads/issues/19
    # Note that c11threads is a workaround for C11 Threads only being
    # introduced in Glibc 2.28 as per:
    # https://sourceware.org/bugzilla/show_bug.cgi?id=14092#c10
    if LIBC_VERSION.to_f < 2.28 && ENV['NESTED_CI']
      puts 'Removing the c11threads include/threads.h from the c11threads package to prevent build failures.'.orange
      FileUtils.rm_f "#{CREW_PREFIX}/include/threads.h"
    end
  end

  def self.install
    system "make -C gdb DESTDIR=#{CREW_DEST_DIR} install"
    system "make -C bfd DESTDIR=#{CREW_DEST_DIR} install"
    system "make -C gdb/data-directory DESTDIR=#{CREW_DEST_DIR} install"
    system "make -C gdbserver DESTDIR=#{CREW_DEST_DIR} install"
    FileUtils.rm_f "#{CREW_DEST_LIB_PREFIX}/libinproctrace.so"
  end
end

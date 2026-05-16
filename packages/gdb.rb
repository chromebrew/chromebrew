# Adapted from Arch Linux gdb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/gdb/trunk/PKGBUILD

require 'buildsystems/autotools'

class Gdb < Autotools
  description 'The GNU Debugger'
  homepage 'https://www.gnu.org/software/gdb/'
  version "17.2-#{CREW_GCC_VER}-#{CREW_PY_VER}"
  license 'GPL3'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/gdb/gdb-#{version.split('-').first}.tar.xz"
  source_sha256 '1c036c0d72e4b3d1fb5c94c88632add6f9d76f4d7c4d2ea793c12a9f19a3228c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bc49e940c4849b860d3a18303d02d56c72439790926ce7063f7471b9b26ed3e2',
     armv7l: 'bc49e940c4849b860d3a18303d02d56c72439790926ce7063f7471b9b26ed3e2',
       i686: 'a82689691f10191896b421fa6995a9b7a26052ee2361f43c38b7d1236d83f24b',
     x86_64: '908e778676a2d17774aec085e1d516989f25396bf768c133809c3c21395a804c'
  })

  depends_on 'binutils' => :executable
  depends_on 'boost' => :executable
  depends_on 'elfutils' # R
  depends_on 'expat' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' # R
  depends_on 'gmp' => :executable
  depends_on 'mpfr' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'python3' => :executable
  depends_on 'readline' => :executable
  depends_on 'source_highlight' => :executable
  depends_on 'texinfo' => :build
  depends_on 'xxhash' => :executable
  depends_on 'xzutils' => :executable
  depends_on 'zlib' # R
  depends_on 'zstd' # R

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

# Adapted from Arch Linux gdb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/gdb/trunk/PKGBUILD

require 'buildsystems/autotools'

class Gdb < Autotools
  description 'The GNU Debugger'
  homepage 'https://www.gnu.org/software/gdb/'
  version '14.1-py3.12'
  license 'GPL3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/gdb/gdb-14.1.tar.xz'
  source_sha256 'd66df51276143451fcbff464cc8723d68f1e9df45a6a2d5635a54e71643edb80'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/14.1-py3.12_armv7l/gdb-14.1-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/14.1-py3.12_armv7l/gdb-14.1-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/14.1-py3.12_i686/gdb-14.1-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/14.1-py3.12_x86_64/gdb-14.1-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '480f63771ac9e063bcd8a09c7033381c5a974a817cb12d89b22bddde0353ff33',
     armv7l: '480f63771ac9e063bcd8a09c7033381c5a974a817cb12d89b22bddde0353ff33',
       i686: 'b406ce513112710967880cf65bdaaede2e25770df312dbc840c0b5b88d24ff9f',
     x86_64: '9af9831acd85d87b5451cc33fca809d81a4e8979c956a1faa21222049ec843e8'
  })

  depends_on 'binutils' # R
  depends_on 'boost' # R
  depends_on 'elfutils' # R
  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'mpfr' # R
  depends_on 'ncurses' # R
  depends_on 'python3' # R
  depends_on 'readline' # R
  depends_on 'source_highlight' # R
  depends_on 'xxhash' # R
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  conflicts_ok # binutils conflicts

  def self.build
    @x = ARCH == 'i686' ? '' : '--with-x'
    FileUtils.mkdir_p 'build'
    Dir.chdir('build') do
      system "../configure \
        #{CREW_OPTIONS} \
        --disable-binutils \
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
        #{@x}"
      system 'make'
    end
  end

  def self.install
    Dir.chdir('build') do
      # Handle missing libopcodes
      # https://gitlab.com/freedesktop-sdk/freedesktop-sdk/-/merge_requests/13697/diffs
      system "make -C gdb DESTDIR=#{CREW_DEST_DIR} install"
      system "make -C opcodes DESTDIR=#{CREW_DEST_DIR} install"
      system "make -C bfd DESTDIR=#{CREW_DEST_DIR} install"
      system "make -C gdb/data-directory DESTDIR=#{CREW_DEST_DIR} install"
      system "make -C gdbserver DESTDIR=#{CREW_DEST_DIR} install"
    end
    FileUtils.rm_f "#{CREW_DEST_LIB_PREFIX}/libinproctrace.so"
  end
end

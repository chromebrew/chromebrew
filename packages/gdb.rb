# Adapted from Arch Linux gdb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/gdb/trunk/PKGBUILD

require 'buildsystems/autotools'

class Gdb < Autotools
  description 'The GNU Debugger'
  homepage 'https://www.gnu.org/software/gdb/'
  version '14.2-py3.12'
  license 'GPL3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/gdb/gdb-14.2.tar.xz'
  source_sha256 '2d4dd8061d8ded12b6c63f55e45344881e8226105f4d2a9b234040efa5ce7772'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2cc54b085cf44964eeb9e7659e149eca4fd46591a045d99dc0176b0f119b77eb',
     armv7l: '2cc54b085cf44964eeb9e7659e149eca4fd46591a045d99dc0176b0f119b77eb',
       i686: '66d38230ff86d7558ebeb66e9f2106a3e51c5d4456c5708acd30ef57481cf8e3',
     x86_64: '3fe3456bd566d259f84c360ec77739fc519fc55abb354f0dc046d968060573ac'
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

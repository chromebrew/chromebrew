# Adapted from Arch Linux gdb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/gdb/trunk/PKGBUILD

require 'buildsystems/autotools'

class Gdb < Autotools
  description 'The GNU Debugger'
  homepage 'https://www.gnu.org/software/gdb/'
  version '15.1-gcc14-py3.12'
  license 'GPL3'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/gnu/gdb/gdb-#{version.split('-').first}.tar.xz"
  source_sha256 '38254eacd4572134bca9c5a5aa4d4ca564cbbd30c369d881f733fb6b903354f2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '32437749840bdb8001a61853f7092535b65a691e68626ced4187ab18ca4c0a86',
     armv7l: '32437749840bdb8001a61853f7092535b65a691e68626ced4187ab18ca4c0a86',
       i686: '931ad01906fb397904974c1df160866e08ca44fab46b35f403d744d5bb40b980',
     x86_64: 'afbdb2d178c49ccdc9f638bbc4e73af2cfe22d7d0e41552996a2adf616624395'
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
  depends_on 'texinfo' => :build
  depends_on 'xxhash' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  conflicts_ok # binutils conflicts

  def self.build
    @x = ARCH == 'i686' ? '' : '--with-x'
    FileUtils.mkdir_p 'build'
    Dir.chdir('build') do
      system "../configure \
        #{CREW_CONFIGURE_OPTIONS} \
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

# Adapted from Arch Linux gdb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/gdb/trunk/PKGBUILD

require 'buildsystems/autotools'

class Gdb < Autotools
  description 'The GNU Debugger'
  homepage 'https://www.gnu.org/software/gdb/'
  version "16.1-#{CREW_GCC_VER}-#{CREW_PY_VER}"
  license 'GPL3'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/gdb/gdb-#{version.split('-').first}.tar.xz"
  source_sha256 '38254eacd4572134bca9c5a5aa4d4ca564cbbd30c369d881f733fb6b903354f2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5f9ae81368ba045330b783686cd514c38ff64c0bbcd3abd2ce1100a8abd28944',
     armv7l: '5f9ae81368ba045330b783686cd514c38ff64c0bbcd3abd2ce1100a8abd28944',
       i686: '6ee75eef105015e2cec081223de1fd4d20ae4537f75a8b07ee5d6184fc48e315',
     x86_64: '2031d00893dd1d97d0b72d628925a779629c625e5052e766714d5ea687e96d86'
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
    system "./configure \
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

  def self.install
    system "make -C gdb DESTDIR=#{CREW_DEST_DIR} install"
    system "make -C bfd DESTDIR=#{CREW_DEST_DIR} install"
    system "make -C gdb/data-directory DESTDIR=#{CREW_DEST_DIR} install"
    system "make -C gdbserver DESTDIR=#{CREW_DEST_DIR} install"
    FileUtils.rm_f "#{CREW_DEST_LIB_PREFIX}/libinproctrace.so"
  end
end

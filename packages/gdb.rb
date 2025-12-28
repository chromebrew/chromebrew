# Adapted from Arch Linux gdb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/gdb/trunk/PKGBUILD

require 'buildsystems/autotools'

class Gdb < Autotools
  description 'The GNU Debugger'
  homepage 'https://www.gnu.org/software/gdb/'
  version "17.1-#{CREW_GCC_VER}-#{CREW_PY_VER}"
  license 'GPL3'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/gdb/gdb-#{version.split('-').first}.tar.xz"
  source_sha256 '14996f5f74c9f68f5a543fdc45bca7800207f91f92aeea6c2e791822c7c6d876'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '74988a13afd23cf7a83bbf12ebeb449527674a87c817a953a75fc7388fe91084',
     armv7l: '74988a13afd23cf7a83bbf12ebeb449527674a87c817a953a75fc7388fe91084',
       i686: 'a82689691f10191896b421fa6995a9b7a26052ee2361f43c38b7d1236d83f24b',
     x86_64: '4d7587b2b4c4f3c5c89db024d03e7fe7785d6c0d8f93bf74b577d74ac5a7513d'
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

  def self.install
    system "make -C gdb DESTDIR=#{CREW_DEST_DIR} install"
    system "make -C bfd DESTDIR=#{CREW_DEST_DIR} install"
    system "make -C gdb/data-directory DESTDIR=#{CREW_DEST_DIR} install"
    system "make -C gdbserver DESTDIR=#{CREW_DEST_DIR} install"
    FileUtils.rm_f "#{CREW_DEST_LIB_PREFIX}/libinproctrace.so"
  end
end

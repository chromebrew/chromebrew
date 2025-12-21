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
    aarch64: 'b35ea59fc1e1a4dd8e804b414c7ebc1d2e7ef570583f2a255d283faa821c24a3',
     armv7l: 'b35ea59fc1e1a4dd8e804b414c7ebc1d2e7ef570583f2a255d283faa821c24a3',
       i686: 'dd0a8be703238de7cadef59e913b247debb16486caa6bb6a3197f469d6fbca26',
     x86_64: '3f0d8801f4e29a0aab46f40eaf61602a02fa679881fed4e6951bf48a153e1012'
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

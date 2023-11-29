# Adapted from Arch Linux gdb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/gdb/trunk/PKGBUILD

require 'package'

class Gdb < Package
  description 'The GNU Debugger'
  homepage 'https://www.gnu.org/software/gdb/'
  version '13.2-py3.11'
  license 'GPL3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/gdb/gdb-13.2.tar.xz'
  source_sha256 'fd5bebb7be1833abdb6e023c2f498a354498281df9d05523d8915babeb893f0a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/13.2-py3.11_armv7l/gdb-13.2-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/13.2-py3.11_armv7l/gdb-13.2-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/13.2-py3.11_i686/gdb-13.2-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/13.2-py3.11_x86_64/gdb-13.2-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'dcd1c83d33b476f72819f88309957e4885222257286af38d6278bf435ac3b112',
     armv7l: 'dcd1c83d33b476f72819f88309957e4885222257286af38d6278bf435ac3b112',
       i686: 'f443297dca5d7e247d6e423b3cfc8bab778ddca02de58fec7ddc36aeed762d45',
     x86_64: '5e55256a5cea3c1f4954900e3b59c99f150d22ebd67b3c499a75a896017dedaf'
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

  def self.build
    FileUtils.mkdir_p 'build'
    Dir.chdir('build') do
      system "CPPFLAGS='-I#{CREW_PREFIX}/include/ncursesw  -lncursesw' \
        ../configure \
        #{CREW_OPTIONS} \
        --disable-nls \
        --enable-64-bit-bfd \
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
        --with-x"
      system 'make'
    end
  end

  def self.install
    Dir.chdir('build') do
      system "make -C gdb DESTDIR=#{CREW_DEST_DIR} install"
      system "make -C gdbserver DESTDIR=#{CREW_DEST_DIR} install"
    end
    # Remove files conflicting with binutils
    FileUtils.rm_f "#{CREW_DEST_PREFIX}/share/info/bfd.info"
    conflict_packages = %w[binutils]
    conflict_packages.each do |package|
      file = File.read("#{CREW_META_PATH}#{package}.filelist")
      file.each_line do |line|
        if File.exist?("#{CREW_DEST_DIR}#{line}")
          FileUtils.rm_f "#{CREW_DEST_DIR}#{line}"
          puts "Removed #{CREW_DEST_DIR}#{line}"
        end
      end
    end
    FileUtils.rm_f "#{CREW_DEST_LIB_PREFIX}/libinproctrace.so"
  end
end

# Adapted from Arch Linux gdb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/gdb/trunk/PKGBUILD

require 'package'

class Gdb < Package
  description 'The GNU Debugger'
  homepage 'https://www.gnu.org/software/gdb/'
  version '11.1-1'
  license 'GPL3'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/gdb/gdb-11.1.tar.xz'
  source_sha256 'cccfcc407b20d343fb320d4a9a2110776dd3165118ffd41f4b1b162340333f94'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/11.1-1_armv7l/gdb-11.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/11.1-1_armv7l/gdb-11.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/11.1-1_i686/gdb-11.1-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/11.1-1_x86_64/gdb-11.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '75f2d705f5142bc3408becdde63b7502ddc48fe48e3fbbbec9e24f701edf8f52',
     armv7l: '75f2d705f5142bc3408becdde63b7502ddc48fe48e3fbbbec9e24f701edf8f52',
       i686: '319fe1962e7c44a8532f96b21951c03be4a689233158cbc7e689eeaf8945aa28',
     x86_64: '67a1c01c1a976bd370b9131bf174aacdc16a03970c2b27a3248b09520a18e802'
  })

  depends_on 'mpfr' # R
  depends_on 'gmp' # R
  depends_on 'source_highlight' # R
  depends_on 'boost' # R

  def self.build
    FileUtils.mkdir_p 'build'
    Dir.chdir('build') do
      system "env #{CREW_ENV_OPTIONS} \
        CPPFLAGS='-I#{CREW_PREFIX}/include/ncursesw  -lncursesw' \
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
    FileUtils.rm "#{CREW_DEST_PREFIX}/share/info/bfd.info" if File.exist?("#{CREW_DEST_PREFIX}/share/info/bfd.info")
    conflict_packages = %w[binutils]
    conflict_packages.each do |package|
      file = File.open("#{CREW_META_PATH}#{package}.filelist").read
      file.each_line do |line|
        if File.exist?("#{CREW_DEST_DIR}#{line}")
          FileUtils.rm_f "#{CREW_DEST_DIR}#{line}"
          puts "Removed #{CREW_DEST_DIR}#{line}"
        end
      end
    end
    FileUtils.rm "#{CREW_DEST_LIB_PREFIX}/libinproctrace.so" if File.exist?("#{CREW_DEST_LIB_PREFIX}/libinproctrace.so")
  end
end

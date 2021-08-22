# Adapted from Arch Linux gdb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/gdb/trunk/PKGBUILD

require 'package'

class Gdb < Package
  description 'The GNU Debugger'
  homepage 'https://www.gnu.org/software/gdb/'
  version '10.2-1'
  license 'GPL3'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/gdb/gdb-10.2.tar.xz'
  source_sha256 'aaa1223d534c9b700a8bec952d9748ee1977513f178727e1bee520ee000b4f29'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/10.2-1_armv7l/gdb-10.2-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/10.2-1_armv7l/gdb-10.2-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/10.2-1_i686/gdb-10.2-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/10.2-1_x86_64/gdb-10.2-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '84de0df44444f2fffac56db0ff50374f3c967f31ff9c889194b9364eb613aa82',
     armv7l: '84de0df44444f2fffac56db0ff50374f3c967f31ff9c889194b9364eb613aa82',
       i686: 'd7bd22e1427da962523a99cd145664e733165520def366b6b081e899d20bdb5b',
     x86_64: 'c407a7749b85e28222946221ecfb73f24aa9f13378f5c8cf4a91f253a059da06'
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

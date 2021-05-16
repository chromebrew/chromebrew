# Adapted from Arch Linux gdb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/gdb/trunk/PKGBUILD

require 'package'

class Gdb < Package
  description 'The GNU Debugger'
  homepage 'https://www.gnu.org/software/gdb/'
  version '10.2'
  license 'GPL3'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/gdb/gdb-10.2.tar.xz'
  source_sha256 'aaa1223d534c9b700a8bec952d9748ee1977513f178727e1bee520ee000b4f29'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/10.2_armv7l/gdb-10.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/10.2_armv7l/gdb-10.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/10.2_i686/gdb-10.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/10.2_x86_64/gdb-10.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'dd17aa02eb51445ac59b3285ac89255eeb96a920f702a336b866157324455bd4',
     armv7l: 'dd17aa02eb51445ac59b3285ac89255eeb96a920f702a336b866157324455bd4',
       i686: 'f9e48ee07f58f571f48e70d311ce6f3428e57d8efda2019a70e6767ae9221039',
     x86_64: '03edf742e370f61a3f7c3efb431e4517501f6841049ab50c4c7faa1d79814bf6'
  })

  depends_on 'libx11'
  depends_on 'mpfr'
  depends_on 'source_highlight'
  depends_on 'texinfo'

  def self.patch
    system "sed -i 's%#include <term.h>%#include <ncursesw/term.h>%g' gdb/gdb_curses.h"
  end

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
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
    # Remove file conflicting with binutils
    FileUtils.rm "#{CREW_DEST_PREFIX}/share/info/bfd.info"
  end
end

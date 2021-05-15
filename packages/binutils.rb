require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools. This also provides the GNU Debugger.'
  homepage 'https://www.gnu.org/software/binutils/'
  version '10.2'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'git://sourceware.org/git/binutils-gdb.git'
  git_hashtag 'ce35d7163e779b1321058b22f005c70ce1524b25'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/10.2_armv7l/binutils-10.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/10.2_armv7l/binutils-10.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/10.2_i686/binutils-10.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/10.2_x86_64/binutils-10.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd40a81b55e9801eb330ca732f9a41899ac411f31c207407d89f1abe128d38645',
     armv7l: 'd40a81b55e9801eb330ca732f9a41899ac411f31c207407d89f1abe128d38645',
       i686: 'ef7cbd28404ab6cf05c6c3545fba364f032c0c0fe2346806f8762a60f8f23194',
     x86_64: '3524c1cad62b2aac6e2fa98f33c215bbdb6cc8e4d7b1a03412e5f77720983798'
  })

  depends_on 'boost' => :build # R (gdb only)
  depends_on 'elfutils' # R
  depends_on 'expat' => :build # R (gdb only)
  depends_on 'flex' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'libx11' => :build
  depends_on 'mpfr' # R
  depends_on 'ncurses' => :build # R (gdb only)
  depends_on 'python3' # R
  depends_on 'readline' => :build # R (gdb only)
  depends_on 'source_highlight' => :build # R (gdb only)
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R

  def self.patch
    system 'filefix'
    system "sed -i 's%#include <term.h>%#include <ncursesw/term.h>%g' gdb/gdb_curses.h"
    system "sed -i 's,scriptdir = \$(tooldir)/lib,scriptdir = \$(tooldir)/#{ARCH_LIB},g' ld/Makefile.am"
    Dir.chdir 'ld' do
      system 'aclocal && automake'
    end
  end

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "env #{CREW_ENV_OPTIONS} \
      CPPFLAGS='-I#{CREW_PREFIX}/include/ncursesw  -lncursesw' \
        ../configure \
        #{CREW_OPTIONS} \
        --disable-maintainer-mode \
        --disable-nls \
        --enable-64-bit-bfd \
        --enable-gold \
        --enable-host-shared \
        --enable-install-libiberty \
        --enable-ld=default \
        --enable-lto \
        --enable-plugins \
        --enable-relro \
        --enable-shared \
        --enable-sim \
        --enable-source-highlight \
        --enable-threads \
        --enable-tui \
        --enable-vtable-verify \
        --with-curses \
        --with-lib-path=#{CREW_LIB_PREFIX} \
        --with-lzma \
        --with-pic \
        --with-pkgversion=Chromebrew \
        --with-python=python3 \
        --with-system-gdbinit=#{CREW_PREFIX}/etc/gdb/gdbinit \
        --with-system-readline \
        --with-system-zlib \
        --with-x"
      system 'make configure-host'
      system 'make'
      system "make tooldir=#{CREW_PREFIX}"
    end
  end

  def self.check
    Dir.chdir 'build' do
      system 'make check || true'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", "prefix=#{CREW_PREFIX}",
             "tooldir=#{CREW_PREFIX}", 'install'
    end
  end

  def self.postinstall
    puts
    puts 'To use gdb, please install the gdb runtime dependencies with:'.lightblue
    puts 'crew install gdb'.lightblue
    puts
  end
end

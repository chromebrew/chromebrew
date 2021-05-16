require 'package'

class Binutils < Package
  description 'The GNU Binutils are a collection of binary tools. This also provides the GNU Debugger.'
  homepage 'https://www.gnu.org/software/binutils/'
  @_ver = '2.36.1'
  version "#{@_ver}-3"
  license 'GPL-3+'
  compatibility 'all'
  source_url 'git://sourceware.org/git/binutils-gdb.git'
  git_hashtag 'f35674005e609660f5f45005a9e095541ca4c5fe'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/2.36.1-3_armv7l/binutils-2.36.1-3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/2.36.1-3_armv7l/binutils-2.36.1-3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/2.36.1-3_i686/binutils-2.36.1-3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/binutils/2.36.1-3_x86_64/binutils-2.36.1-3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0af31b71dacb0c63ee5670e23dea5fc51ff70968f279923256ecfd00abd51816',
     armv7l: '0af31b71dacb0c63ee5670e23dea5fc51ff70968f279923256ecfd00abd51816',
       i686: 'd86abe680b7ce662a525b4cd46e6f6fbed4e0512598e1f1b2969bc2ba9337c90',
     x86_64: 'f7d230441ba09d2697c0337eb551a49b391844c1a215378bcc801460f2c5273e'
  })

  depends_on 'zlibpkg' # R
  depends_on 'elfutils' # R
  depends_on 'flex' # R

  def self.patch
    system 'filefix'
    system "sed -i 's%#include <term.h>%#include <ncursesw/term.h>%g' gdb/gdb_curses.h"
    system "sed -i 's,scriptdir = \$(tooldir)/lib,scriptdir = \$(tooldir)/#{ARCH_LIB},g' ld/Makefile.am"
    # Turn off development mode (-Werror, gas run-time checks, date in sonames)
    system "sed -i '/^development=/s/true/false/' bfd/development.sh"
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
        --disable-gdb \
        --disable-gdb-server \
        --disable-werror \
        --disable-maintainer-mode \
        --disable-nls \
        --enable-64-bit-bfd \
        --enable-cet \
        --enable-gold \
        --enable-host-shared \
        --enable-install-libiberty \
        --enable-ld=default \
        --enable-lto \
        --enable-plugins \
        --enable-relro \
        --enable-shared \
        --enable-threads \
        --enable-vtable-verify \
        --with-lib-path=#{CREW_LIB_PREFIX} \
        --with-lzma \
        --with-pic \
        --with-pkgversion=Chromebrew \
        --with-python=python3 \
        --with-system-gdbinit=#{CREW_PREFIX}/etc/gdb/gdbinit"
      system 'make configure-host'
      system 'make'
      system "make tooldir=#{CREW_PREFIX}"
    end
  end

  def self.check
    Dir.chdir 'build' do
      system 'make -k LDFLAGS="" check || true'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", "prefix=#{CREW_PREFIX}",
             "tooldir=#{CREW_PREFIX}", 'install'
    end
  end
end

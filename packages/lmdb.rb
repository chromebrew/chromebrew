# Adapted from Arch Linux lmdb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/lmdb/trunk/PKGBUILD

require 'package'

class Lmdb < Package
  description 'Symas Lightning Memory-Mapped Database'
  homepage 'https://www.symas.com/mdb'
  version '1.0.0'
  license 'OpenLDAP Public License'
  compatibility 'all'
  source_url 'https://git.openldap.org/openldap/openldap.git'
  git_hashtag "LMDB_#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '850f6f955d930fb1685b5888d2a629fb2854386c0cb92ff05bb6760a87be5ede',
     armv7l: '850f6f955d930fb1685b5888d2a629fb2854386c0cb92ff05bb6760a87be5ede',
       i686: '0d2557faf2753f28a723f81f1cb4011edcd37fc9eec4171bf950d12451e4cb2d',
     x86_64: 'b7033cda2ead987972ffa619bab481344bf743ac1155651a43bea4828958b9e4'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  def self.patch
    system "sed -i 's,libdir = $(exec_prefix)/lib,libdir = $(exec_prefix)/lib#{CREW_LIB_SUFFIX},g' liblmdb/Makefile"
    system "sed -i 's,prefix	= /usr/local,prefix	= #{CREW_PREFIX},g' liblmdb/Makefile"
    system "sed -i 's,OPT = -O2 -g,OPT = -O2 -g -flto=auto,g' liblmdb/Makefile"
  end

  def self.build
    system "make -C liblmdb prefix=#{CREW_PREFIX}"
    @lmdb_pc = <<~LMDB_PC_EOF
      prefix=#{CREW_PREFIX}
      libdir=#{CREW_LIB_PREFIX}
      includedir=${prefix}/include

      Name: liblmdb
      Description: Lightning Memory-Mapped Database
      URL: https://symas.com/products/lightning-memory-mapped-database/
      Version: #{version}
      Libs: -L${libdir} -llmdb
      Cflags: -I${includedir}
    LMDB_PC_EOF
  end

  def self.install
    system "make -C liblmdb DESTDIR=#{CREW_DEST_DIR} install"
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/pkgconfig/"
    File.write("#{CREW_DEST_LIB_PREFIX}/pkgconfig/lmdb.pc", @lmdb_pc)
  end
end

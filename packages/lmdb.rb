# Adapted from Arch Linux lmdb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/lmdb/trunk/PKGBUILD

require 'package'

class Lmdb < Package
  description 'Symas Lightning Memory-Mapped Database'
  homepage 'https://www.symas.com/mdb'
  version '0.9.35'
  license 'OpenLDAP Public License'
  compatibility 'all'
  source_url 'https://git.openldap.org/openldap/openldap.git'
  git_hashtag "LMDB_#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a0e922d6b3c2a81469c422d43324b3cb6054b918011d0cad2bfeee4b12234b7b',
     armv7l: 'a0e922d6b3c2a81469c422d43324b3cb6054b918011d0cad2bfeee4b12234b7b',
       i686: '62d7d2b5a9606c7aa21b0fff9f28ade116c72ddbe3f9f3d1e38eda09ca7de23e',
     x86_64: '585187e82d821def830be9c41dd0677f8aecaebbfe752f0fb85bcd4d0b577941'
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

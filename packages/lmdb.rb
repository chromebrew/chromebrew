# Adapted from Arch Linux lmdb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/lmdb/trunk/PKGBUILD

require 'package'

class Lmdb < Package
  description 'Symas Lightning Memory-Mapped Database'
  homepage 'https://symas.com/mdb'
  version '0.9.31'
  license 'OpenLDAP Public License'
  compatibility 'all'
  source_url "https://git.openldap.org/openldap/openldap/-/archive/LMDB_#{version}/openldap-LMDB_#{version}.tar.gz"
  source_sha256 'd35d4f6f46313d62fd342c9dcbf574432919ce5e802d2b6cbe2ebd549821e5c4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4a8b49cf540611175663e4a47f5cb6a7422453737d46fd9cb719a5405c810a66',
     armv7l: '4a8b49cf540611175663e4a47f5cb6a7422453737d46fd9cb719a5405c810a66',
       i686: 'f1fbdc2025a46ab1792331948cabacf6aa3d9e98cd9beba1f253e79871f5932d',
     x86_64: 'bfa7fb9b53043b3294ea1ca4d1556470d1dcde611acfefb8c49b8d6919f433c7'
  })

  depends_on 'glibc' # R
  depends_on 'gcc_lib' # R

  def self.patch
    system "sed -i 's,libdir = $(exec_prefix)/lib,libdir = $(exec_prefix)/lib#{CREW_LIB_SUFFIX},g' libraries/liblmdb/Makefile"
    system "sed -i 's,prefix	= /usr/local,prefix	= #{CREW_PREFIX},g' libraries/liblmdb/Makefile"
    system "sed -i 's,OPT = -O2 -g,OPT = -O2 -g -flto=auto,g' libraries/liblmdb/Makefile"
  end

  def self.build
    Dir.chdir 'libraries/liblmdb' do
      system "make prefix=#{CREW_PREFIX}"
    end
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
    Dir.chdir 'libraries/liblmdb' do
      system "make DESTDIR=#{CREW_DEST_DIR} install"
    end
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/pkgconfig/"
    File.write("#{CREW_DEST_LIB_PREFIX}/pkgconfig/lmdb.pc", @lmdb_pc)
  end
end

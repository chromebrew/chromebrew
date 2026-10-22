# Adapted from Arch Linux lmdb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/lmdb/trunk/PKGBUILD

require 'package'

class Lmdb < Package
  description 'Symas Lightning Memory-Mapped Database'
  homepage 'https://www.symas.com/mdb'
  version '1.0.3'
  license 'OpenLDAP Public License'
  compatibility 'all'
  source_url 'https://git.openldap.org/openldap/openldap.git'
  git_hashtag "LMDB_#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '87afd912f8e9162ae34c67ec0bb78de01101b3a14231ad1676fccac84c584558',
     armv7l: '87afd912f8e9162ae34c67ec0bb78de01101b3a14231ad1676fccac84c584558',
       i686: '8dd4a64e914e4255aa7407495d99bfd0b32112e49ebf6c380a3300c2257e1995',
     x86_64: 'b0d83d84fc7a9ee7a70aaa249c6f576d24d35a6c228baa32c601682e04cbc6b3'
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

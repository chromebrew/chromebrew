# Adapted from Arch Linux lmdb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/lmdb/trunk/PKGBUILD

require 'package'

class Lmdb < Package
  description 'Symas Lightning Memory-Mapped Database'
  homepage 'https://www.symas.com/mdb'
  version '1.0.2'
  license 'OpenLDAP Public License'
  compatibility 'all'
  source_url 'https://git.openldap.org/openldap/openldap.git'
  git_hashtag "LMDB_#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0fbe60140223da34cd8fe71da9117f203cd6770fa146fe335c46609267dcb76b',
     armv7l: '0fbe60140223da34cd8fe71da9117f203cd6770fa146fe335c46609267dcb76b',
       i686: '07e08385a98845acd3acc594df91b45dcf7124a92ec56262d6dd345dea07b79d',
     x86_64: '79a0fd141e1a284b8915f83fd2c561884c86b01c6734d97b999d96358ed43be0'
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

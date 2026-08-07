# Adapted from Arch Linux lmdb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/lmdb/trunk/PKGBUILD

require 'package'

class Lmdb < Package
  description 'Symas Lightning Memory-Mapped Database'
  homepage 'https://www.symas.com/mdb'
  version '1.0.1'
  license 'OpenLDAP Public License'
  compatibility 'all'
  source_url 'https://git.openldap.org/openldap/openldap.git'
  git_hashtag "LMDB_#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bd0882cb46e04a037e9651b36c24f10465009a9c4618e075a17b00b7400a74b8',
     armv7l: 'bd0882cb46e04a037e9651b36c24f10465009a9c4618e075a17b00b7400a74b8',
       i686: 'c324c0c890cb3d4f1aa5c98bfbab4b639a93bbdd3e9a49ee88fafb36d010f645',
     x86_64: '83fd193b067608392e438071624fbdeb002c3f6b6fb1ae19af4c00b6c00ac8c7'
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

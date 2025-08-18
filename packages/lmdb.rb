# Adapted from Arch Linux lmdb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/lmdb/trunk/PKGBUILD

require 'package'

class Lmdb < Package
  description 'Symas Lightning Memory-Mapped Database'
  homepage 'https://www.symas.com/mdb'
  version '0.9.33'
  license 'OpenLDAP Public License'
  compatibility 'all'
  source_url "https://git.openldap.org/openldap/openldap/-/archive/LMDB_#{version}/openldap-LMDB_#{version}.tar.gz"
  source_sha256 '476801f5239c88c7de61c3390502a5d13965ecedef80105b5fb0fcb8373d1e53'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fb7a48d43b3d95cd74b71abe0fa87e544fc8d274df6a48e367d6a5de4e86ad40',
     armv7l: 'fb7a48d43b3d95cd74b71abe0fa87e544fc8d274df6a48e367d6a5de4e86ad40',
       i686: '5a295f0f2b29455bce60d7e4e098e21c2fe228c1aa3e64b43c0416c41188c29e',
     x86_64: '17fd317ffb609d8b197c1b6734be90022a303e648c2bddb035861a1b5af463aa'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

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

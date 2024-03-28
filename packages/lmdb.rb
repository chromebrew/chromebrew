# Adapted from Arch Linux lmdb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/lmdb/trunk/PKGBUILD

require 'package'

class Lmdb < Package
  description 'Symas Lightning Memory-Mapped Database'
  homepage 'https://symas.com/mdb'
  version '0.9.32'
  license 'OpenLDAP Public License'
  compatibility 'all'
  source_url "https://git.openldap.org/openldap/openldap/-/archive/LMDB_#{version}/openldap-LMDB_#{version}.tar.gz"
  source_sha256 '70d553f80968f5117f2f3d4d7f0b89cb8fb69dadc35131263a2499bb58f7d015'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '321830d5af7e98f3f302a915866dd81183102c7b7c911298e32c82aebedaa00b',
     armv7l: '321830d5af7e98f3f302a915866dd81183102c7b7c911298e32c82aebedaa00b',
       i686: '81275127275f8d4faa718dc28d4f2fd894394d94005f99474699bd49c3f81aac',
     x86_64: '4c23c5666baf7c2c488d1eb5f50dcaaa1eb137b5dd394778d1eaf44c714dfd90'
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

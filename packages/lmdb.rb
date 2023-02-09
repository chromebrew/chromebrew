# Adapted from Arch Linux lmdb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/lmdb/trunk/PKGBUILD

require 'package'

class Lmdb < Package
  description 'Symas Lightning Memory-Mapped Database'
  homepage 'https://symas.com/mdb'
  version '0.9.29'
  license 'OpenLDAP Public License'
  compatibility 'all'
  source_url "https://git.openldap.org/openldap/openldap/-/archive/LMDB_#{version}/openldap-LMDB_#{version}.tar.gz"
  source_sha256 'd4c668167a2d703ef91db733b4069b8b74dbc374405855be6626b45e2a7e2dd3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lmdb/0.9.29_armv7l/lmdb-0.9.29-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lmdb/0.9.29_armv7l/lmdb-0.9.29-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lmdb/0.9.29_i686/lmdb-0.9.29-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lmdb/0.9.29_x86_64/lmdb-0.9.29-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0459de4035dccce3ab4e8ca3b7ee061447d530fbb526e97c20c143e7688dc7a7',
     armv7l: '0459de4035dccce3ab4e8ca3b7ee061447d530fbb526e97c20c143e7688dc7a7',
       i686: '8489cc379f9fd20c638b753c8218750f496ef10364897cef6ef9c7121fd1e127',
     x86_64: '8209022816c95b209a720ba22897064a86f7e6a44006b148c20681a1eba658eb'
  })

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
      includedir=\${prefix}/include

      Name: liblmdb
      Description: Lightning Memory-Mapped Database
      URL: https://symas.com/products/lightning-memory-mapped-database/
      Version: #{version}
      Libs: -L\${libdir} -llmdb
      Cflags: -I\${includedir}
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

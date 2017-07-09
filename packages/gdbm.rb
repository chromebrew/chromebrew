require 'package'

class Gdbm < Package
  description 'GNU dbm is a set of database routines that use extensible hashing.'
  homepage 'https://www.gnu.org/software/gdbm/'
  version '1.13'
  source_url 'ftp://ftp.gnu.org/gnu/gdbm/gdbm-1.13.tar.gz'
  source_sha256 '9d252cbd7d793f7b12bcceaddda98d257c14f4d1890d851c386c37207000a253'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/gdbm-1.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/gdbm-1.13-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/gdbm-1.13-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/gdbm-1.13-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5173374cf85d85db067e74762347b29221bf6b145bff4297491cab41716f90dd',
     armv7l: '5173374cf85d85db067e74762347b29221bf6b145bff4297491cab41716f90dd',
       i686: 'abea0445b1b6be0365aa76340676b39118c6b2de094ee0e21d391ad6fabcd0ef',
     x86_64: 'c6d4f4a421a04df6c9e6e2d99cfecce673fd58788e378978b2bc8c7312e4d4a6',
  })

  depends_on 'readline'

  def self.build
    system './configure', "--libdir=#{CREW_LIB_PREFIX}", '--disable-static', '--enable-shared', '--with-pic'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make check"
  end
end

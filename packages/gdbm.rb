require 'package'

class Gdbm < Package
  description 'GNU dbm is a set of database routines that use extensible hashing.'
  homepage 'https://www.gnu.org/software/gdbm/'
  version '1.13'
  source_url 'ftp://ftp.gnu.org/gnu/gdbm/gdbm-1.13.tar.gz'
  source_sha256 '9d252cbd7d793f7b12bcceaddda98d257c14f4d1890d851c386c37207000a253'

  depends_on 'readline'

  def self.build
    system './configure', '--disable-static', '--enable-shared', '--with-pic'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make check"
  end
end

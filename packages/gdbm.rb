require 'package'
 
class Gdbm < Package
  description 'GNU dbm is a set of database routines that use extensible hashing.'
  homepage 'https://www.gnu.org/software/gdbm/'
  version '1.13'
  source_url 'ftp://ftp.gnu.org/gnu/gdbm/gdbm-1.13.tar.gz'
  source_sha1 '7f2a8301497bbcac91808b011ca533380914fd21'
  
  depends_on 'readline'
  
  def self.build
    system './configure', '--disable-static', '--enable-shared', '--with-pic'
    system 'make'
    system "find . -name 'lib*.so.*' -print | xargs strip -S"
  end
  
  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
  end

  def self.check
    system "make check"
  end
end

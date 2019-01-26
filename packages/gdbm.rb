require 'package'

class Gdbm < Package
  description 'GNU dbm is a set of database routines that use extensible hashing.'
  homepage 'https://www.gnu.org/software/gdbm/'
  version '1.18.1'
  source_url 'https://ftpmirror.gnu.org/gdbm/gdbm-1.18.1.tar.gz'
  source_sha256 '86e613527e5dba544e73208f42b78b7c022d4fa5a6d5498bf18c8d6f745b91dc'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'readline7'

  def self.build
    system './configure',
           '--disable-static',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end

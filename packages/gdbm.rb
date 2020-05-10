require 'package'

class Gdbm < Package
  description 'GNU dbm is a set of database routines that use extensible hashing.'
  homepage 'https://www.gnu.org/software/gdbm/'
  version '1.18.1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gdbm/gdbm-1.18.1.tar.gz'
  source_sha256 '86e613527e5dba544e73208f42b78b7c022d4fa5a6d5498bf18c8d6f745b91dc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gdbm-1.18.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gdbm-1.18.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gdbm-1.18.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gdbm-1.18.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b7d1eefc792b5250b4a1e1c6cf7845cb965944c5f2f4468b63201e6dc7374d66',
     armv7l: 'b7d1eefc792b5250b4a1e1c6cf7845cb965944c5f2f4468b63201e6dc7374d66',
       i686: '60deef61ee53f9aab9a94767a8902ee29920302e113ca115567f3b2d428ae582',
     x86_64: 'b52cde5502c9bf35fe485776d976d1a44a872e2ffee8964297ac2fe3ef0d064e',
  })

  depends_on 'readline'

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

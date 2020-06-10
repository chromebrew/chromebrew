require 'package'

class Tdb < Package
  description 'tdb is a simple database API for sharing structures between parts of Samba'
  homepage 'https://tdb.samba.org/'
  version '1.4.2'
  compatibility 'all'
  source_url 'https://www.samba.org/ftp/tdb/tdb-1.4.2.tar.gz'
  source_sha256 '9040b2cce4028e392f063f91bbe76b8b28fecc2b7c0c6071c67b5eb3168e004a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tdb-1.4.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tdb-1.4.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tdb-1.4.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tdb-1.4.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ac4d32692af3cfe0ebd435f9430ea9fec744c7f7c025a86c2cd3f5264611a2c3',
     armv7l: 'ac4d32692af3cfe0ebd435f9430ea9fec744c7f7c025a86c2cd3f5264611a2c3',
       i686: '8d2fbd994ccf182e052f4acde3c260c0288fcad389ed6c3efda9cc6b7dcb81f1',
     x86_64: '6bf6145c78500ae1b869419d2530ed7266fc404c532874d6aa5fc612314f3551',
  })

  depends_on 'docbook_xsl'
  depends_on 'libxslt'
  depends_on 'python3'

  def self.build
    system './configure',
           'configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

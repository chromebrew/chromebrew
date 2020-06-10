require 'package'

class Figlet < Package
  description 'FIGlet is a program for making large letters out of ordinary text.'
  homepage 'http://www.figlet.org/'
  version '2.2.5'
  compatibility 'all'
  source_url 'ftp://ftp.figlet.org/pub/figlet/program/unix/figlet-2.2.5.tar.gz'
  source_sha256 'bf88c40fd0f077dab2712f54f8d39ac952e4e9f2e1882f1195be9e5e4257417d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/figlet-2.2.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/figlet-2.2.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/figlet-2.2.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/figlet-2.2.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6f4f9e4777710551e5ff6a7da662f628bb150f29ff8cec5cdc5763c3fd24f16f',
     armv7l: '6f4f9e4777710551e5ff6a7da662f628bb150f29ff8cec5cdc5763c3fd24f16f',
       i686: 'e8a3bf134593f61e6cae88cd202db8a23007e6313c847299ba29e0f254d23ef5',
     x86_64: 'd4e024831412e63a6c722cbd1c0c2b51e702c3b10739fa597741123f6126738b',
  })

  def self.build
    system "make", "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

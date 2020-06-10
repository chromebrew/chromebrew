require 'package'

class Cabextract < Package
  description 'cabextract is Free Software for extracting Microsoft cabinet files, also called .CAB files.'
  homepage 'https://www.cabextract.org.uk/'
  version '1.9.1'
  compatibility 'all'
  source_url 'https://www.cabextract.org.uk/cabextract-1.9.1.tar.gz'
  source_sha256 'afc253673c8ef316b4d5c29cc4aa8445844bee14afffbe092ee9469405851ca7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cabextract-1.9.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cabextract-1.9.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cabextract-1.9.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cabextract-1.9.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e3e343dc5e467c5ae85b2ad35aa8328c0aba6a16d31cc446cf315f14b679a3b0',
     armv7l: 'e3e343dc5e467c5ae85b2ad35aa8328c0aba6a16d31cc446cf315f14b679a3b0',
       i686: '9b29b9f805f70eff97e123195ad3c02cffab758df4e50b4ece27dd3a8d48d42b',
     x86_64: 'e16f2d0c9b9d4306a254bd575e8453d8215e8ec50172d4483cce1a92bfda437c',
  })

  def self.build
    system './configure', "--prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

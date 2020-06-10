require 'package'

class Openpam < Package
  description 'OpenPAM is an open source PAM library that focuses on simplicity, correctness, and cleanliness.'
  homepage 'https://www.openpam.org/'
  version '20170430'
  compatibility 'all'
  source_url 'https://www.openpam.org/downloads/35'
  source_sha256 '22f65222e9faf5729ee5d2db7796d81f95df1a54b03e89ae4713c85e939be85f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openpam-20170430-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openpam-20170430-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/openpam-20170430-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openpam-20170430-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e1b31c8686b2722f923a660fd8599a5c846aa873140ffa0516393f58e09c458d',
     armv7l: 'e1b31c8686b2722f923a660fd8599a5c846aa873140ffa0516393f58e09c458d',
       i686: '38cd52755d074178e9284f830e2c4917655fc274e97c98d799a383829e25ecff',
     x86_64: 'ef479ccabafa687208070e0df8d13668d3c3206679d16b67efe7bfb5d30ea09d',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

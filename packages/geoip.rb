require 'package'

class Geoip < Package
  description 'GeoIP Legacy C API.'
  homepage 'https://github.com/maxmind/geoip-api-c/'
  version '1.6.11-1'
  source_url 'https://github.com/maxmind/geoip-api-c/releases/download/v1.6.11/GeoIP-1.6.11.tar.gz'
  source_sha256 'b0e5a92200b5ab540d118983f7b7191caf4faf1ae879c44afa3ff2a2abcdb0f5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/geoip-1.6.11-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/geoip-1.6.11-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/geoip-1.6.11-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/geoip-1.6.11-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0fb9972f1b61e229725ab8c28f5f4f2c8b1ee4aa9aa10c20efd4c9192c07f455',
     armv7l: '0fb9972f1b61e229725ab8c28f5f4f2c8b1ee4aa9aa10c20efd4c9192c07f455',
       i686: '505dbc96ae411c89f3b1b2431766a29ae65c62464f077c3427c4140efab4c38f',
     x86_64: '82497d5946ca23fe878649e1e05c999dd2d4c7cc1224683a92013422d6980d14',
  })

  def self.build
    system './configure', "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

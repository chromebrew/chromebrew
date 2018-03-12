require 'package'

class Fixesproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '5.0-0'
  source_url 'https://www.x.org/archive/individual/proto/fixesproto-5.0.tar.gz'
  source_sha256 '67865a0e3cdc7dec1fd676f0927f7011ad4036c18eb320a2b41dbd56282f33b8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fixesproto-5.0-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fixesproto-5.0-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fixesproto-5.0-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fixesproto-5.0-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ae85ec2d41106e1c91cfc3b5723f100d699cae87ea8e6576a0e1fb73acffe249',
     armv7l: 'ae85ec2d41106e1c91cfc3b5723f100d699cae87ea8e6576a0e1fb73acffe249',
       i686: 'a4d9a4ede7cc9d6bac8fb8bb356a5bab82e0da528333f8a2b40c341134ce9a9a',
     x86_64: '51f5ecc4d0d240ad423ad0caaf07af3baa72d887f36e4eabc6f97c2da4914f7e',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

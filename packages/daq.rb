require 'package'

class Daq < Package
  description 'Data Acquisition library, for packet I/O.'
  homepage 'https://www.snort.org'
  version '2.0.6'
  compatibility 'all'
  source_url 'https://www.snort.org/downloads/snort/daq-2.0.6.tar.gz'
  source_sha256 'd41da5f7793e66044e6927dd868c0525e7ee4ec1a3515bf74ef9a30cd9273af0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/daq-2.0.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/daq-2.0.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/daq-2.0.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/daq-2.0.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e886d91158b996eac4c5510945fed80906b328aea842bd588db5acc080a3ff4c',
     armv7l: 'e886d91158b996eac4c5510945fed80906b328aea842bd588db5acc080a3ff4c',
       i686: 'c5e045e96062109cd5693b95be378ebcef385d4fb6d6c7f3d1b6857b670af297',
     x86_64: 'db3de1a94b02f47c15ae68b905f53fc7c6e6aef0845c28b03d4dd35f51d8f00b',
  })

  depends_on 'libpcap'

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

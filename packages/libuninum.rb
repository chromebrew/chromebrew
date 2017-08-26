require 'package'

class Libuninum < Package
  description 'This is a library for converting Unicode strings to numbers and numbers to Unicode strings.'
  homepage 'http://billposer.org/Software/libuninum.html'
  version '2.7'
  source_url 'http://billposer.org/Software/Downloads/libuninum-2.7.tar.bz2'
  source_sha256 'e704983c3c00e9b76bd836b8b83ce31bfe4eb1752eee8be123cf97c1275076ea'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libuninum-2.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libuninum-2.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libuninum-2.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libuninum-2.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '18bc6fcaf15f5443eb075d3a2e59cec88d888a74765c4e06d5f19abb865f10b6',
     armv7l: '18bc6fcaf15f5443eb075d3a2e59cec88d888a74765c4e06d5f19abb865f10b6',
       i686: '5aad178fbad0c84e929745b7ce484a08bfeeaf0a24f9b2f09cc552f0ae5b0532',
     x86_64: '996bf80e88330fe09cdf1c52525d652ec40c93c7ee18d072b737917d678f333a',
  })

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

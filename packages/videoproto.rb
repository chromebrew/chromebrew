require 'package'

class Videoproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '2.3.3-0'
  source_url 'https://www.x.org/archive/individual/proto/videoproto-2.3.3.tar.gz'
  source_sha256 'df8dfeb158767f843054248d020e291a2c40f7f5e0ac6d8706966686fee7c5c0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/videoproto-2.3.3-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/videoproto-2.3.3-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/videoproto-2.3.3-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/videoproto-2.3.3-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '983566580a329860f1bea5a39c11335ede6310c62223823ab93e3e408f700f1b',
     armv7l: '983566580a329860f1bea5a39c11335ede6310c62223823ab93e3e408f700f1b',
       i686: '92de581336d619278b22382b53a0e4bd0a0e1582c098285760bc7a52b9518668',
     x86_64: '874d64679e5a942f15e2845ec550679a7479a06508c32984923ccbc770720b79',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

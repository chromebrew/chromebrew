require 'package'

class Videoproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '2.3.3'
  source_url 'https://www.x.org/archive/individual/proto/videoproto-2.3.3.tar.gz'
  source_sha256 'df8dfeb158767f843054248d020e291a2c40f7f5e0ac6d8706966686fee7c5c0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/videoproto-2.3.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/videoproto-2.3.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/videoproto-2.3.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/videoproto-2.3.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2efdd05ecf33938e1a6482549a520b2afc3988ff2f51bfe974c3cfa7d047858d',
     armv7l: '2efdd05ecf33938e1a6482549a520b2afc3988ff2f51bfe974c3cfa7d047858d',
       i686: '07f73fe4632f17953c57f3784102a33bcfcc8258b6679b66f394e4e82a871b72',
     x86_64: '009d945280af302570fe1b2712e5d781f27f545bb0f604160fce0168a054efdc',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

require 'package'

class Renderproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '0.11'
  source_url 'https://www.x.org/archive/individual/proto/renderproto-0.11.tar.gz'
  source_sha256 '256e4af1d3b4007872a276ed9e5c2522f80f5fe69b97268542917635b4dbf758'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/renderproto-0.11-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/renderproto-0.11-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/renderproto-0.11-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/renderproto-0.11-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0bef022fec20e834ea3d6b6e342df04d591715ecfff1556b672bf661683bb2ea',
     armv7l: '0bef022fec20e834ea3d6b6e342df04d591715ecfff1556b672bf661683bb2ea',
       i686: '40cb379868cf7e69bee85fdb56176e49c7d7f56ae4cfb0186ac328d3bae1c92b',
     x86_64: '3650a1c5c787158da694b7e26a6a78ac5f1dd695ae2ab904e7eabf577b228440',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

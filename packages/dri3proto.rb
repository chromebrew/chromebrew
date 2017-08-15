require 'package'

class Dri3proto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.0'
  source_url 'https://www.x.org/archive/individual/proto/dri3proto-1.0.tar.gz'
  source_sha256 'e1a0dad3009ecde52c0bf44187df5f95cc9a7cc0e76dfc2f2bbf3e909fe03fa9'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/dri3proto-1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/dri3proto-1.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/dri3proto-1.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/dri3proto-1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '59a2797ad28d69e185a9b625200d5bb5b01d8ea8f97620e873601df3c1061f56',
     armv7l: '59a2797ad28d69e185a9b625200d5bb5b01d8ea8f97620e873601df3c1061f56',
       i686: '805f4048bdc5da1e60d99cc7018348dc14fdee613e326a5af5d5469497c9c4fe',
     x86_64: '3715c6aeab1c8ed9aafc281cc69b14f2cb996f84aace65c837ca8bd03a12684d',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

require 'package'

class Randrproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.5.0'
  source_url 'https://www.x.org/archive/individual/proto/randrproto-1.5.0.tar.gz'
  source_sha256 '8f8a716d6daa6ba05df97d513960d35a39e040600bf04b313633f11679006fab'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/randrproto-1.5.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/randrproto-1.5.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/randrproto-1.5.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/randrproto-1.5.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b16a2662a549eea1b3bac6db8a7c083e287030b89d09188e4a19057a5b3ef0ee',
     armv7l: 'b16a2662a549eea1b3bac6db8a7c083e287030b89d09188e4a19057a5b3ef0ee',
       i686: '92127747b4107c7109d924fd45621c7bb722c971547f4a542c27b9ddd2cf4b69',
     x86_64: 'e12a59e8cb3d547f793e07ef8aab211bdbd5514395976205cfefcce9b582b8d8',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

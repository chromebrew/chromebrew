require 'package'

class Inputproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '2.3'
  source_url 'https://www.x.org/archive/individual/proto/inputproto-2.3.tar.gz'
  source_sha256 '98e8ab87fb71080b28536d749aa942bdad13d860d5eb3e1271084906cda711e9'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/inputproto-2.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/inputproto-2.3-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/inputproto-2.3-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/inputproto-2.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '435dc7fe9d8b54b2b8029fa710b95578db41627af1209daff4a77f4b4edc92b7',
     armv7l: '435dc7fe9d8b54b2b8029fa710b95578db41627af1209daff4a77f4b4edc92b7',
       i686: '2870a4bf50843ec0fbbc17237273a74f7e0fb8bc40d9e0e4f6d1f393b9e88a45',
     x86_64: 'bf722a8104485097c0108835ef0f0b815ad918767bf941c4e47650dcd6055129',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

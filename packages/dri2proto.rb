require 'package'

class Dri2proto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '2.8-0'
  source_url 'https://www.x.org/archive/individual/proto/dri2proto-2.8.tar.gz'
  source_sha256 '7e65b031eaa6ebe23c75583d4abd993ded7add8009b4200a4db7aa10728b0f61'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dri2proto-2.8-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dri2proto-2.8-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dri2proto-2.8-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dri2proto-2.8-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd462c6e13b4cb1db2f37b69f3974074da81a29a91d97aec7d2e142e3e8820d41',
     armv7l: 'd462c6e13b4cb1db2f37b69f3974074da81a29a91d97aec7d2e142e3e8820d41',
       i686: '3320bb311f0de5520b0ebb0a6438b00cdbe7f8af5f7eb92d80e8b223f9c218ba',
     x86_64: '189d77874c4cd1543100876fe7b41da09c490fa82327e7c0f6105d077300c393',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

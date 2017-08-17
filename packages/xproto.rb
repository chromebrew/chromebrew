require 'package'

class Xproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '7.0.31'
  source_url 'https://www.x.org/archive/individual/proto/xproto-7.0.31.tar.gz'
  source_sha256 '6d755eaae27b45c5cc75529a12855fed5de5969b367ed05003944cf901ed43c7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xproto-7.0.31-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xproto-7.0.31-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xproto-7.0.31-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xproto-7.0.31-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '389a8b55ee5fc1b9b84f65bf83d01cab1f53c02f42d2250ea466435bcef962f9',
     armv7l: '389a8b55ee5fc1b9b84f65bf83d01cab1f53c02f42d2250ea466435bcef962f9',
       i686: '52dd0287f7559b36d0ff53167ccce86112bde6837f61ff847c038557e3afaffd',
     x86_64: '0f191e884e22416bafc19f5fdeea1b08aa8419757935631e7322ca2d01642cfe',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

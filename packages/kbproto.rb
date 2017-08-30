require 'package'

class Kbproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.0.7'
  source_url 'https://www.x.org/archive/individual/proto/kbproto-1.0.7.tar.gz'
  source_sha256 '828cb275b91268b1a3ea950d5c0c5eb076c678fdf005d517411f89cc8c3bb416'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/kbproto-1.0.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/kbproto-1.0.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/kbproto-1.0.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/kbproto-1.0.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '284eac5d88585adac8f575f0a931e4ba98ee483ee1ee668e29abf4d1ad3fa562',
     armv7l: '284eac5d88585adac8f575f0a931e4ba98ee483ee1ee668e29abf4d1ad3fa562',
       i686: 'b07ee8f81a49eb4d1098cfdce9a824a781c875fb8dc4dbc62063da26f0e8528d',
     x86_64: 'e29ea6755fe5d9c1bc0437e6d4005281ff42f4fc7bd0f31f2da1d041568715f5',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

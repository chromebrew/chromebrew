require 'package'

class Glproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.4.17'
  source_url 'https://www.x.org/archive/individual/proto/glproto-1.4.17.tar.gz'
  source_sha256 '9d8130fec2b98bd032db7730fa092dd9dec39f3de34f4bb03ceb43b9903dbc96'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glproto-1.4.17-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glproto-1.4.17-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glproto-1.4.17-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glproto-1.4.17-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '338528ba16b9bc296339d33f28de0d61d772f6918cdd048f2cb0ef6739cdbde5',
     armv7l: '338528ba16b9bc296339d33f28de0d61d772f6918cdd048f2cb0ef6739cdbde5',
       i686: 'a0f405296f44e1b8905c834b73d8730552a284fc6d0ad2ef7370b54a3e8386c5',
     x86_64: '11f451888c66c6fd23612c3e0b3189f5fe3c12c8b288ce67f591c3cf2c97101c',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

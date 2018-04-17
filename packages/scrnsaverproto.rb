require 'package'

class Scrnsaverproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.2.2-0'
  source_url 'https://www.x.org/archive/individual/proto/scrnsaverproto-1.2.2.tar.gz'
  source_sha256 'd8dee19c52977f65af08fad6aa237bacee11bc5a33e1b9b064e8ac1fd99d6e79'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/scrnsaverproto-1.2.2-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/scrnsaverproto-1.2.2-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/scrnsaverproto-1.2.2-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/scrnsaverproto-1.2.2-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '911e804878ff88713771433ff937821b4ac831901cb6979e12176beca961b24d',
     armv7l: '911e804878ff88713771433ff937821b4ac831901cb6979e12176beca961b24d',
       i686: 'f00931a17960b6c177e2b70184e3e28fb4f45b46c85f6d4704293693a3ac4ec0',
     x86_64: 'eb5e24e58ff98838f728cc44494c043bde6c945fc3a244f557b4f2c1fc8053e5',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

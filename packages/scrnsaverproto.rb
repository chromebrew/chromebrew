require 'package'

class Scrnsaverproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.2.2'
  source_url 'https://www.x.org/archive/individual/proto/scrnsaverproto-1.2.2.tar.gz'
  source_sha256 'd8dee19c52977f65af08fad6aa237bacee11bc5a33e1b9b064e8ac1fd99d6e79'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/scrnsaverproto-1.2.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/scrnsaverproto-1.2.2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/scrnsaverproto-1.2.2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/scrnsaverproto-1.2.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd476ab25bbc17a38937e86b8e8aac3cd688621bda05aed6bacc6f60e5c79e2fc',
     armv7l: 'd476ab25bbc17a38937e86b8e8aac3cd688621bda05aed6bacc6f60e5c79e2fc',
       i686: 'adc94637ae47ed54d41540b6a0aced4f6caf451e6c667d0540e5f141cd41ce53',
     x86_64: 'abd380db68248fe5c46b2b5ea2b8c297b384f3a98eb9ee446c10a52ae12e56a2',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

require 'package'

class Applewmproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.4.2'
  source_url 'https://www.x.org/archive/individual/proto/applewmproto-1.4.2.tar.gz'
  source_sha256 'ff8ac07d263a23357af2d6ff0cca3c1d56b043ddf7797a5a92ec624f4704df2e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/applewmproto-1.4.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/applewmproto-1.4.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/applewmproto-1.4.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/applewmproto-1.4.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c612d881bafcbb42f5925d50104bd369c63054a8ac8a7497e4101792b3cf7f21',
     armv7l: 'c612d881bafcbb42f5925d50104bd369c63054a8ac8a7497e4101792b3cf7f21',
       i686: 'c1cf06085a13040c87663e71ebca94afd23523fa10275dea4fae89b48422b74d',
     x86_64: '3fa02e245f6fb77c23117e5fb677eebfb6b41515cd4a77c44e2decfae3f5cd80',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

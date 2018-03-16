require 'package'

class Renderproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '0.11-0'
  source_url 'https://www.x.org/archive/individual/proto/renderproto-0.11.tar.gz'
  source_sha256 '256e4af1d3b4007872a276ed9e5c2522f80f5fe69b97268542917635b4dbf758'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/renderproto-0.11-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/renderproto-0.11-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/renderproto-0.11-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/renderproto-0.11-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2637fd927fedc4f7f8f9ca77eee67c37fbde936deebdfb2047e61145a21674a4',
     armv7l: '2637fd927fedc4f7f8f9ca77eee67c37fbde936deebdfb2047e61145a21674a4',
       i686: '55c47ff8b5f97c3d6c8cc969ce8ef4ec73361bdd541d5dd2e5bc887fa6e3c1e4',
     x86_64: 'c5e9fa7b349c5437bc1adb281f92d7be2a0efcc42e1ce0bd0581e947d62f83da',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

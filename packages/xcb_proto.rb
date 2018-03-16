require 'package'

class Xcb_proto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.12-0'
  source_url 'https://www.x.org/archive/individual/xcb/xcb-proto-1.12.tar.gz'
  source_sha256 'cfa49e65dd390233d560ce4476575e4b76e505a0e0bacdfb5ba6f8d0af53fd59'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_proto-1.12-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_proto-1.12-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_proto-1.12-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_proto-1.12-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f47314d58e562f5589b493e8d706dec77e6ddb29e67bcc39d2e1e003d58a21e4',
     armv7l: 'f47314d58e562f5589b493e8d706dec77e6ddb29e67bcc39d2e1e003d58a21e4',
       i686: 'd88237e6a04039dd2e9840bf5aaa5922c085aff13f14673aca68a8307ad486b6',
     x86_64: '70b5922c8c39cc68d0e59f868a7c32b68b0ff4ebf1818db486f8febd23412636',
  })
  
  depends_on 'python27' => :build 

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

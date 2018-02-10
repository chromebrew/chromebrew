require 'package'

class Xcb_proto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.12'
  source_url 'https://www.x.org/archive/individual/xcb/xcb-proto-1.12.tar.gz'
  source_sha256 'cfa49e65dd390233d560ce4476575e4b76e505a0e0bacdfb5ba6f8d0af53fd59'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_proto-1.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_proto-1.12-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_proto-1.12-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_proto-1.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e8e6db2f25df64d3b5a1d1718a64030c5589d22d78d47c5f7844ae88ff69dfea',
     armv7l: 'e8e6db2f25df64d3b5a1d1718a64030c5589d22d78d47c5f7844ae88ff69dfea',
       i686: '321e8479a559cbb9c726d5ddb44556eda41dbcf4a7ee9a6ff6f1e46426ca3618',
     x86_64: 'd1b2f9c4c8ab6de2f496efabfd614a89fd38499091a4b7a82ba4b221499dd1a7',
  })
  
  depends_on 'python27' => :build
  
  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

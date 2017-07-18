require 'package'

class Xextproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '7.3.0'
  source_url 'https://www.x.org/archive/individual/proto/xextproto-7.3.0.tar.gz'
  source_sha256 '1b1bcdf91221e78c6c33738667a57bd9aaa63d5953174ad8ed9929296741c9f5'

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

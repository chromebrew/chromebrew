require 'package'

class Dmxproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '2.3'
  source_url 'https://www.x.org/archive/individual/proto/dmxproto-2.3.tar.gz'
  source_sha256 'a911a086a61c1bb16d35f70b391f167744ee721b5e2a7f22c00bc5a2c1ecb242'

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

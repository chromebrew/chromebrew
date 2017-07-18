require 'package'

class Xineramaproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.2'
  source_url 'https://www.x.org/archive/individual/proto/xineramaproto-1.2.tar.gz'
  source_sha256 'd1298f7e3bea0790bd3c93516b83ff4551b20b544c50fd231d53fc4b5ba93100'

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

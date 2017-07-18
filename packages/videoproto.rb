require 'package'

class Videoproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage ''
  version '2.3.3'
  source_url 'https://www.x.org/archive/individual/proto/videoproto-2.3.3.tar.gz'
  source_sha256 'df8dfeb158767f843054248d020e291a2c40f7f5e0ac6d8706966686fee7c5c0'

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

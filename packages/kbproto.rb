require 'package'

class Kbproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage ''
  version '1.0.7'
  source_url 'https://www.x.org/archive/individual/proto/kbproto-1.0.7.tar.gz'
  source_sha256 '828cb275b91268b1a3ea950d5c0c5eb076c678fdf005d517411f89cc8c3bb416'

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

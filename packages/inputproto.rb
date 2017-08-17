require 'package'

class Inputproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '2.3'
  source_url 'https://www.x.org/archive/individual/proto/inputproto-2.3.tar.gz'
  source_sha256 '98e8ab87fb71080b28536d749aa942bdad13d860d5eb3e1271084906cda711e9'

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

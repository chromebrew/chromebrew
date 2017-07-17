require 'package'

class Inputproto < Package
  description ''
  homepage ''
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

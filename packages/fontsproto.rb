require 'package'

class Fontsproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage ''
  version '2.1.3'
  source_url 'https://www.x.org/archive/individual/proto/fontsproto-2.1.3.tar.gz'
  source_sha256 '72c44e63044b2b66f6fa112921621ecc20c71193982de4f198d9a29cda385c5e'

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

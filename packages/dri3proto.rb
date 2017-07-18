require 'package'

class Dri3proto < Package
  description ''
  homepage ''
  version '1.0'
  source_url 'https://www.x.org/archive/individual/proto/dri3proto-1.0.tar.gz'
  source_sha256 'e1a0dad3009ecde52c0bf44187df5f95cc9a7cc0e76dfc2f2bbf3e909fe03fa9'

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

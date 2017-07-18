require 'package'

class Damageproto < Package
  description ''
  homepage ''
  version '1.2.1'
  source_url 'https://www.x.org/archive/individual/proto/damageproto-1.2.1.tar.gz'
  source_sha256 'f65ccbf1de9750a527ea6e85694085b179f2d06495cbdb742b3edb2149fef303'

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

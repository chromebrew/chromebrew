require 'package'

class Renderproto < Package
  description ''
  homepage ''
  version '0.11'
  source_url 'https://www.x.org/archive/individual/proto/renderproto-0.11.tar.gz'
  source_sha256 '256e4af1d3b4007872a276ed9e5c2522f80f5fe69b97268542917635b4dbf758'

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

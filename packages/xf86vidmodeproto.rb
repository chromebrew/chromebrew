require 'package'

class Xf86vidmodeproto < Package
  description ''
  homepage ''
  version '2.3'
  source_url 'https://www.x.org/archive/individual/proto/xf86vidmodeproto-2.3.tar.gz'
  source_sha256 '4bdb8d868f65783f58d9619232a31a2c309e7ae15d24ce5efc579a732aaa271d'

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

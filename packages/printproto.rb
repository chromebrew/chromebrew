require 'package'

class Printproto < Package
  description ''
  homepage ''
  version '1.0.5'
  source_url 'https://www.x.org/archive/individual/proto/printproto-1.0.5.tar.gz'
  source_sha256 'e8b6f405fd865f0ea7a3a2908dfbf06622f57f2f91359ec65d13b955e49843fc'

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

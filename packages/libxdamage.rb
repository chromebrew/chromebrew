require 'package'

class Libxdamage < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.1.4'
  source_url 'https://www.x.org/archive/individual/lib/libXdamage-1.1.4.tar.gz'
  source_sha256 '4bb3e9d917f5f593df2277d452926ee6ad96de7b7cd1017cbcf4579fe5d3442b'

  depends_on 'fixesproto'
  depends_on 'libxfixes'
  depends_on 'xextproto'
  depends_on 'libx11'
  depends_on 'damageproto'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

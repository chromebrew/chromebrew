require 'package'

class Libxp < Package
  description 'x print service extension library'
  homepage 'https://xorg.freedesktop.org'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/lib/libXp-1.0.3.tar.bz2'
  source_sha256 '7f360c9905849c3587d48efc0f0ecbc852c19f61a52b18530d6b005cb9148c57'

  depends_on 'xorg_proto'
  depends_on 'libxext'
  depends_on 'printproto'

  def self.build
      system "./configure #{CREW_OPTIONS} --enable-malloc0returnsnull"
      system "make -j#{CREW_NPROC}"
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end

require 'package'

class Libxv < Package
  description 'X.org X Window System video extension library'
  homepage 'http://www.x.org'
  version '1.0.11'
  source_url 'https://www.x.org/archive/individual/lib/libXv-1.0.11.tar.gz'
  source_sha256 'c4112532889b210e21cf05f46f0f2f8354ff7e1b58061e12d7a76c95c0d47bb1'

  depends_on 'videoproto'
  depends_on 'libxext'
  depends_on 'libx11'
  depends_on 'xextproto'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
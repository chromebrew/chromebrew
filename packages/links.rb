require 'package'

class Links < Package
  description 'Links is text WWW browser with tables and frames.'
  homepage 'http://www.jikos.cz/~mikulas/links/'
  version '1.03'
  source_url 'http://www.jikos.cz/~mikulas/links/download/links-1.03.tar.gz'
  source_sha1 '659b2492c97a1416855d3e0f5a5f18aed5160b8a'

  depends_on "openssl"

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" 
  end
end

require 'package'

class Links < Package
  description 'Links is text WWW browser with tables and frames.'
  homepage 'http://www.jikos.cz/~mikulas/links/'
  version '1.03'
  source_url 'http://www.jikos.cz/~mikulas/links/download/links-1.03.tar.gz'
  source_sha256 '32443c6f011216a8a43ed0806d9d23c1defdd19bc4b021ee00cda197782e175a'

  depends_on 'openssl'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

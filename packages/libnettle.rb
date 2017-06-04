require 'package'

class Libnettle < Package
  version '3.3'
  source_url 'https://ftp.gnu.org/gnu/nettle/nettle-3.3.tar.gz'
  source_sha1 'bf2b4d3a41192ff6177936d7bc3bee4cebeb86c4'

  depends_on "openssl"

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" 
  end
end

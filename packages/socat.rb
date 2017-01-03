require 'package'

class Socat < Package
  version '1.7.3.1' 
  source_url 'http://www.dest-unreach.org/socat/download/socat-1.7.3.1.tar.gz'
  source_sha1 'a6f1d8ab3e85f565dbe172f33a9be6708dd52ffb'

  depends_on 'readline'
  depends_on 'openssl'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

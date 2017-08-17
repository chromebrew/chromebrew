require 'package'

class Socat < Package
  description 'SOcket CAT is a multipurpose relay \'netcat++\' (extended design, new implementation).'
  homepage 'http://www.dest-unreach.org/socat/'
  version '1.7.3.2'
  source_url 'http://www.dest-unreach.org/socat/download/socat-1.7.3.2.tar.gz'
  source_sha256 'ce3efc17e3e544876ebce7cd6c85b3c279fda057b2857fcaaf67b9ab8bdaf034'

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

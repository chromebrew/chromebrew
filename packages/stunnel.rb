require 'package'

class Stunnel < Package
  description "Stunnel is a proxy designed to add TLS encryption functionality to existing clients and servers without any changes in the programs' code."
  homepage 'https://www.stunnel.org/index.html'
  version '5.42'
  source_url 'https://www.stunnel.org/downloads/stunnel-5.42.tar.gz'
  source_sha256 '1b6a7aea5ca223990bc8bd621fb0846baa4278e1b3e00ff6eee279cb8e540fab'

  depends_on 'openssl'

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

require 'package'

class Stunnel < Package
  description "Stunnel is a proxy designed to add TLS encryption functionality to existing clients and servers without any changes in the programs' code."
  homepage 'https://www.stunnel.org/index.html'
  version '5.44'
  source_url 'https://www.stunnel.org/downloads/stunnel-5.44.tar.gz'
  source_sha256 '990a325dbb47d77d88772dd02fbbd27d91b1fea3ece76c9ff4461eca93f12299'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'openssl'

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

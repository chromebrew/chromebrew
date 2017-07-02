require 'package'

class Stunnel < Package
  description "Stunnel is a proxy designed to add TLS encryption functionality to existing clients and servers without any changes in the programs' code."
  homepage 'https://www.stunnel.org/index.html'
  version '5.41'
  source_url 'https://www.stunnel.org/downloads/stunnel-5.41.tar.gz'
  source_sha256 'f05c6321ee1f6ddebacc234ccf20825971941e831b5beea6d0ce0b8e1668148f'

  depends_on 'openssl'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

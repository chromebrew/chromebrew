require 'package'

class Calcurse < Package
  description 'calcurse is a calendar and scheduling application for the command line.'
  homepage 'http://calcurse.org/'
  version '4.3.0'
  source_url 'http://calcurse.org/files/calcurse-4.3.0.tar.gz'
  source_sha256 '31ecc3dc09e1e561502b4c94f965ed6b167c03e9418438c4a7ad5bad2c785f9a'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

require 'package'

class Cabextract < Package
  description 'cabextract is Free Software for extracting Microsoft cabinet files, also called .CAB files.'
  homepage 'https://www.cabextract.org.uk/'
  version '1.9.1'
  source_url 'https://www.cabextract.org.uk/cabextract-1.9.1.tar.gz'
  source_sha256 'afc253673c8ef316b4d5c29cc4aa8445844bee14afffbe092ee9469405851ca7'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './configure', "--prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

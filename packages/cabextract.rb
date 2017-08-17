require 'package'

class Cabextract < Package
  description 'cabextract is Free Software for extracting Microsoft cabinet files, also called .CAB files.'
  homepage 'https://www.cabextract.org.uk/'
  version '1.6'
  source_url 'https://www.cabextract.org.uk/cabextract-1.6.tar.gz'
  source_sha256 'cee661b56555350d26943c5e127fc75dd290b7f75689d5ebc1f04957c4af55fb'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

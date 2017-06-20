require 'package'

class Cabextract < Package
  description 'cabextract is Free Software for extracting Microsoft cabinet files, also called .CAB files.'
  homepage 'https://www.cabextract.org.uk/'
  version '1.6'
  source_url 'https://www.cabextract.org.uk/cabextract-1.6.tar.gz'
  source_sha1 '64f6d5056d3e417a943648c23cb22218b7079ced'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

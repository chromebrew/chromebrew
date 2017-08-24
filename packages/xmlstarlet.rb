require 'package'

class Xmlstarlet < Package
  description 'XMLStarlet is a command line XML toolkit which can be used to transform, query, validate, and edit XML documents and files using simple set of shell commands in similar way it is done for plain text files using grep/sed/awk/tr/diff/patch.'
  homepage 'http://xmlstar.sourceforge.net/'
  version '1.6.1'
  source_url 'https://downloads.sourceforge.net/project/xmlstar/xmlstarlet/1.6.1/xmlstarlet-1.6.1.tar.gz'
  source_sha256 '15d838c4f3375332fd95554619179b69e4ec91418a3a5296e7c631b7ed19e7ca'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

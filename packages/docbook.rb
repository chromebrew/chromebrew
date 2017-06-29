require 'package'

class Docbook < Package
  description 'DocBook is an XML vocabulary that lets you create documents in a presentation-neutral form that captures the logical structure of your content.'
  homepage 'http://docbook.sourceforge.net/'
  version '1.79.1'
  source_url 'https://downloads.sourceforge.net/project/docbook/docbook-xsl/1.79.1/docbook-xsl-1.79.1.tar.bz2'
  source_sha256 '725f452e12b296956e8bfb876ccece71eeecdd14b94f667f3ed9091761a4a968'

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/docbook"
    system "cp -r . #{CREW_DEST_DIR}/usr/local/docbook"
  end
end

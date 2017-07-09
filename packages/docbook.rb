require 'package'

class Docbook < Package
  description 'DocBook is an XML vocabulary that lets you create documents in a presentation-neutral form that captures the logical structure of your content.'
  homepage 'http://docbook.sourceforge.net/'
  version '1.79.1'
  source_url 'https://downloads.sourceforge.net/project/docbook/docbook-xsl/1.79.1/docbook-xsl-1.79.1.tar.bz2'
  source_sha256 '725f452e12b296956e8bfb876ccece71eeecdd14b94f667f3ed9091761a4a968'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/docbook-1.79.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/docbook-1.79.1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/docbook-1.79.1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/docbook-1.79.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '46c4bc0ba85310a7dbd317ccf82d1a01d84fed57844fe1ab402c97e7dfff214b',
     armv7l: '46c4bc0ba85310a7dbd317ccf82d1a01d84fed57844fe1ab402c97e7dfff214b',
       i686: 'f920e1e335360b845136dcd6ae16d6802db8c6a363f728122b25ba9b272d5f22',
     x86_64: '4cb9846d4a824f015b86a7c633877e8716a52fa2f3d76cc2a9d1149ef3b49b3a',
  })

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/docbook"
    system "cp -r . #{CREW_DEST_DIR}/usr/local/docbook"
  end
end

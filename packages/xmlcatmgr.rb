require 'package'

class Xmlcatmgr < Package
  description 'XML and SGML catalog manager'
  homepage 'https://xmlcatmgr.sourceforge.net'
  version '2.2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/sourceforge/xmlcatmgr/xmlcatmgr-2.2.tar.gz'
  source_sha256 'ea1142b6aef40fbd624fc3e2130cf10cf081b5fa88e5229c92b8f515779d6fdc'


  def self.build
      system "./configure #{CREW_OPTIONS} "
      system 'make'
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end

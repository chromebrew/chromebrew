require 'package'

class Docx2txt < Package
  description 'docx2txt is a perl based command line utility to convert Microsoft Office(Tm) Docx documents to equivalent Text documents.'
  homepage 'http://docx2txt.sourceforge.net/'
  version '1.4'
  compatibility 'all'
  source_url 'http://downloads.sourceforge.net/project/docx2txt/docx2txt/v1.4/docx2txt-1.4.tgz'
  source_sha256 'b297752910a404c1435e703d5aedb4571222bd759fa316c86ad8c8bbe58c6d1b'

  def self.install
    system "sed -i 's,/etc,#{CREW_PREFIX}/etc,' docx2txt.pl"
    system "install -Dm644 docx2txt.config #{CREW_DEST_PREFIX}/etc/docx2txt.config"
    system "install -Dm755 docx2txt.pl #{CREW_DEST_PREFIX}/bin/docx2txt.pl"
    system "install -Dm755 docx2txt.sh #{CREW_DEST_PREFIX}/bin/docx2txt"
  end
end

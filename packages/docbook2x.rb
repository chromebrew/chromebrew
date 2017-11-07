require 'package'

class Docbook2x < Package
  description 'docbook2X is a software package that converts DocBook documents into the traditional Unix man page format and the GNU Texinfo format.'
  homepage 'http://docbook2x.sourceforge.net/'
  version '0.8.8'
  source_url 'https://downloads.sourceforge.net/project/docbook2x/docbook2x/0.8.8/docbook2X-0.8.8.tar.gz'
  source_sha256 '4077757d367a9d1b1427e8d5dfc3c49d993e90deabc6df23d05cfe9cd2fcdc45'

  depends_on 'perl_xml_sax_parserfactory'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

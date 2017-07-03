require 'package'

class Datamash < Package
  description 'GNU Datamash is a command-line program which performs basic numeric,textual and statistical operations on input textual data files.'
  homepage 'http://savannah.gnu.org/projects/datamash'
  version '1.1.1'
  source_url 'http://ftpmirror.gnu.org/datamash/datamash-1.1.1.tar.gz'
  source_sha256 'f5e0837f24f427a093f1c5a4b670381ca84054b22687469dc040651fe6c3562d'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

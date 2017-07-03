require 'package'

class Datamash < Package
  description 'GNU Datamash is a command-line program which performs basic numeric,textual and statistical operations on input textual data files.'
  homepage 'http://savannah.gnu.org/projects/datamash'
  version '1.1.1'
  source_url 'http://ftp.gnu.org/gnu/datamash/datamash-1.1.1.tar.gz'
  source_sha256 '420819b3d7372ee3ce704add847cff7d08c4f8176c1d48735d4a632410bb801b'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

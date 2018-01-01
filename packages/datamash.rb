require 'package'

class Datamash < Package
  description 'GNU Datamash is a command-line program which performs basic numeric,textual and statistical operations on input textual data files.'
  homepage 'http://savannah.gnu.org/projects/datamash'
  version '1.2'
  source_url 'https://mirror.sergal.org/gnu/datamash/datamash-1.2.tar.gz'
  source_sha256 'e8d46fb22ccc77e5380f26cde622a733f363d388b04a2c22e7fb6de0e9d85996'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

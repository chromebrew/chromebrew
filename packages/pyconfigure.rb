require 'package'

class Pyconfigure < Package
  description 'GNU pyconfigure provides developers with file templates for implementing standard configure scripts and Makefile recipes for their Python packages.'
  homepage 'https://www.gnu.org/software/pyconfigure/'
  version '0.2.3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/pyconfigure/pyconfigure-0.2.3.tar.gz'
  source_sha256 '37438ee1ae0aad7692188c7d01218cb407a1c89f3efdb5d360311b7ade4ab14f'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

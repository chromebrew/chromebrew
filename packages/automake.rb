require 'package'

class Automake < Package
  description 'Automake is a tool for automatically generating Makefile.in files compliant with the GNU Coding Standards.'
  homepage 'https://www.gnu.org/software/automake/'
  version '1.16.3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/automake/automake-1.16.3.tar.gz'
  source_sha256 'ce010788b51f64511a1e9bb2a1ec626037c6d0e7ede32c1c103611b9d3cba65f'

  depends_on 'autoconf'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

require 'package'

class Automake < Package
  description 'Automake is a tool for automatically generating Makefile.in files compliant with the GNU Coding Standards.'
  homepage 'http://www.gnu.org/software/automake/'
  version '1.15.1'
  source_url 'https://ftp.gnu.org/gnu/automake/automake-1.15.1.tar.xz'
  source_sha256 'af6ba39142220687c500f79b4aa2f181d9b24e4f8d8ec497cea4ba26c64bedaf'

  depends_on 'autoconf'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

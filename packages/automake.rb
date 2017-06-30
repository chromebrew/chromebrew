require 'package'

class Automake < Package
  description 'Automake is a tool for automatically generating Makefile.in files compliant with the GNU Coding Standards.'
  homepage 'http://www.gnu.org/software/automake/'
  version '1.15'
  source_url 'ftp://ftp.gnu.org/gnu/automake/automake-1.15.tar.xz'
  source_sha256 '9908c75aabd49d13661d6dcb1bc382252d22cc77bf733a2d55e87f2aa2db8636'

  depends_on 'autoconf'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

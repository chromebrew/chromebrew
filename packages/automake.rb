require 'package'

class Automake < Package
  description 'Automake is a tool for automatically generating Makefile.in files compliant with the GNU Coding Standards.'
  homepage 'http://www.gnu.org/software/automake/'
  version '1.16.2'
  source_url 'https://ftpmirror.gnu.org/automake/automake-1.16.2.tar.xz'
  source_sha256 'ccc459de3d710e066ab9e12d2f119bd164a08c9341ca24ba22c9adaa179eedd0'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'autoconf'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

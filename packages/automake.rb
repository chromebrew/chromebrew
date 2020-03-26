require 'package'

class Automake < Package
  description 'Automake is a tool for automatically generating Makefile.in files compliant with the GNU Coding Standards.'
  homepage 'http://www.gnu.org/software/automake/'
  version '1.16.2'
  source_url 'https://ftpmirror.gnu.org/automake/automake-1.16.2.tar.xz'
  source_sha256 'ccc459de3d710e066ab9e12d2f119bd164a08c9341ca24ba22c9adaa179eedd0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/automake-1.16.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/automake-1.16.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/automake-1.16.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/automake-1.16.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3f318d4d4873a656e805ee7a60f9d442922f6e2f0efffd7c6639f43f98d727a3',
     armv7l: '3f318d4d4873a656e805ee7a60f9d442922f6e2f0efffd7c6639f43f98d727a3',
       i686: '4df8a089bfeef4610ad7a1e6eb303fbd8e49182252522dc2a2ddac4aa173c648',
     x86_64: 'b24ad3589d0ea2ad97f213157ccca85a965d268cf128dabf9e5d11243d77babc',
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

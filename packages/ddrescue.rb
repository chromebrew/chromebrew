require 'package'

class Ddrescue < Package
  description 'GNU ddrescue is a data recovery tool.'
  homepage 'https://www.gnu.org/software/ddrescue/'
  version '1.25'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/ddrescue/ddrescue-1.25.tar.lz'
  source_sha256 'ce538ebd26a09f45da67d3ad3f7431932428231ceec7a2d255f716fa231a1063'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ddrescue-1.25-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ddrescue-1.25-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ddrescue-1.25-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ddrescue-1.25-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'abc719d94dc994ffc18cbe065e6606282d04f78652cab536897af2773b447d0d',
     armv7l: 'abc719d94dc994ffc18cbe065e6606282d04f78652cab536897af2773b447d0d',
       i686: 'b53bcbb1219c17db6cc3979e792a847904b0782ac2f045ad26bacfdbc52ed44e',
     x86_64: '8fca45af7835153cff43b00cebc1a990b450070f7e7de16887d9ff4b91bcdf0e',
  })

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --enable-non-posix"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end

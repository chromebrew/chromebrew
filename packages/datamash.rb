require 'package'

class Datamash < Package
  description 'GNU Datamash is a command-line program which performs basic numeric,textual and statistical operations on input textual data files.'
  homepage 'http://savannah.gnu.org/projects/datamash'
  version '1.3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/datamash/datamash-1.3.tar.gz'
  source_sha256 'eebb52171a4353aaad01921384098cf54eb96ebfaf99660e017f6d9fc96657a6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/datamash-1.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/datamash-1.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/datamash-1.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/datamash-1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a5c3eccb59d8a85d3b6f171b7c1df2b153676dbbda431426660716a9ebf96db5',
     armv7l: 'a5c3eccb59d8a85d3b6f171b7c1df2b153676dbbda431426660716a9ebf96db5',
       i686: '460e8b86133b5813a38b9f83b6fc205979eae456954d2a0228a3ac4e252c2282',
     x86_64: '488eaf7f76c84ca7632aacf55e87293a2602129d68bfe9f7780ac51f0af56f52',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

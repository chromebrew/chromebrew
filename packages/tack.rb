require 'package'

class Tack < Package
  description 'terminfo action checker'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '1.08'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/ncurses/tack-1.08.tar.gz'
  source_sha256 '60f8515eed87176e1f74ac81372645df14dcffbf200d778353e56f640d55b1f2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tack-1.08-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tack-1.08-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tack-1.08-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tack-1.08-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '835d4e924796bda30b6f39c1ed8f198e238ff5eaf8e442d84329d9ccdf458554',
     armv7l: '835d4e924796bda30b6f39c1ed8f198e238ff5eaf8e442d84329d9ccdf458554',
       i686: '6ed5873d0abbd38ea4611d68a474666eccb706f8bce1fb9fa354e8a21c42c262',
     x86_64: 'c45d3013d0874dd8d6203e4b3871f94b1cc84beb33c5576d3a8d1840e8ccd9f5',
  })

  depends_on 'ncurses'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

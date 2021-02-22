require 'package'

class Gnuchess < Package
  description 'GNU Chess is a chess-playing program.'
  homepage 'https://www.gnu.org/software/chess/'
  version '6.2.7'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/chess/gnuchess-6.2.7.tar.gz'
  source_sha256 'e536675a61abe82e61b919f6b786755441d9fcd4c21e1c82fb9e5340dd229846'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnuchess-6.2.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnuchess-6.2.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnuchess-6.2.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnuchess-6.2.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'beaa12320b833a03fcf58db484efd22b32e5a51feb50548345a298e316ca0915',
     armv7l: 'beaa12320b833a03fcf58db484efd22b32e5a51feb50548345a298e316ca0915',
       i686: 'b26f068d1463c64b5ef92537110e8d6b18896d9b3b3e16e316148fcd2481d307',
     x86_64: 'd2a753a59caa3072e77a99e604b6adf81f4baccc5002e2ad8742a4e500ac8cd2',
  })

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --with-readline"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end

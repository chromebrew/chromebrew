require 'package'

class Gnuchess < Package
  description 'GNU Chess is a chess-playing program.'
  homepage 'https://www.gnu.org/software/chess/'
  version '6.2.7'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/chess/gnuchess-6.2.7.tar.gz'
  source_sha256 'e536675a61abe82e61b919f6b786755441d9fcd4c21e1c82fb9e5340dd229846'

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

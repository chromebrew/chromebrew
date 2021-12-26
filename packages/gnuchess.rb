require 'package'

class Gnuchess < Package
  description 'GNU Chess is a chess-playing program.'
  homepage 'https://www.gnu.org/software/chess/'
  version '6.2.9'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/chess/gnuchess-6.2.9.tar.gz'
  source_sha256 'ddfcc20bdd756900a9ab6c42c7daf90a2893bf7f19ce347420ce36baebc41890'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
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

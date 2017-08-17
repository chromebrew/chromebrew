require 'package'

class Tig < Package
  description 'Tig is an ncurses-based text-mode interface for git.'
  homepage 'http://jonas.nitro.dk/tig/'
  version '2.2.2'
  source_url 'https://github.com/jonas/tig/archive/tig-2.2.2.tar.gz'
  source_sha256 '01a8e3ceb7aab9fd6298eccd6349cb7e813c4fc396d0da41e8c48edf6570c487'

  depends_on 'automake'
  depends_on 'readline'
  depends_on 'ncurses'

  def self.build
    system "./autogen.sh"
    system "./configure", "--prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

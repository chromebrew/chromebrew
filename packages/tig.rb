require 'package'

class Tig < Package
  description 'Tig is an ncurses-based text-mode interface for git.'
  homepage 'http://jonas.nitro.dk/tig/'
  version '2.2.1'
  source_url 'https://github.com/jonas/tig/archive/tig-2.2.1.tar.gz'
  source_sha256 '92d96635068d779df58aea3fbfa86c5869e39c11c7868d5b3d62229360b5336f'

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

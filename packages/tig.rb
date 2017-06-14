require 'package'

class Tig < Package
  description 'Tig is an ncurses-based text-mode interface for git.'
  homepage 'http://jonas.nitro.dk/tig/'
  version '2.2.1'
  source_url 'https://github.com/jonas/tig/archive/tig-2.2.1.tar.gz'
  source_sha1 '704e35ad3f54024d7ce14dade4294aacc0744b3d'
  
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

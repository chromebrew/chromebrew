require 'package'

class Ncdu < Package
  description 'Ncdu is a disk usage analyzer with an ncurses interface.'
  homepage 'https://dev.yorhel.nl/ncdu'
  version '1.12'
  source_url 'https://dev.yorhel.nl/download/ncdu-1.12.tar.gz'
  source_sha256 '820e4e4747a2a2ec7a2e9f06d2f5a353516362c22496a10a9834f871b877499a'

  depends_on 'ncurses'

  def self.build
    system "./configure --prefix=/usr/local CPPFLAGS=-I/usr/local/include/ncurses"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

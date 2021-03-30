require 'package'

class Ncdu < Package
  description 'Ncdu is a disk usage analyzer with an ncurses interface.'
  homepage 'https://dev.yorhel.nl/ncdu'
  version '1.12-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://dev.yorhel.nl/download/ncdu-1.12.tar.gz'
  source_sha256 '820e4e4747a2a2ec7a2e9f06d2f5a353516362c22496a10a9834f871b877499a'


  depends_on 'ncursesw'

  def self.build
    system "./configure #{CREW_OPTIONS} CPPFLAGS=-I#{CREW_PREFIX}/include/ncursesw"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

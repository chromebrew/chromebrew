require 'package'

class Ncurses < Package
  version '5.9'
  source_url 'ftp://ftp.gnu.org/pub/gnu/ncurses/ncurses-5.9.tar.gz'
  source_sha1 '3e042e5f2c7223bffdaac9646a533b8c758b65b5'

  depends_on "diffutils"

  def self.build
    system "./configure CFLAGS=\" -fPIC\" --without-debug --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

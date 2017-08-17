require 'package'

class Screen < Package
  description 'Screen is a full-screen window manager that multiplexes a physical terminal between several processes, typically interactive shells.'
  homepage 'https://www.gnu.org/software/screen/'
  version '4.6.1'
  source_url 'ftp://ftp.gnu.org/gnu/screen/screen-4.6.1.tar.gz'
  source_sha256 'aba9af66cb626155d6abce4703f45cce0e30a5114a368bd6387c966cbbbb7c64'

  depends_on 'ncurses'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

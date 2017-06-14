require 'package'

class Screen < Package
  description 'Screen is a full-screen window manager that multiplexes a physical terminal between several processes, typically interactive shells.'
  homepage 'https://www.gnu.org/software/screen/'
  version '4.3.1'
  source_url 'ftp://ftp.gnu.org/gnu/screen/screen-4.3.1.tar.gz'
  source_sha1 'a524761504e28480517e338b20c852f2ab100c93'
  
  depends_on 'ncurses'
  
  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end
  
  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

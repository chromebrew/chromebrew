require 'package'

class Screen < Package
  description 'Screen is a full-screen window manager that multiplexes a physical terminal between several processes, typically interactive shells.'
  homepage 'https://www.gnu.org/software/screen/'
  version '4.3.1'
  source_url 'ftp://ftp.gnu.org/gnu/screen/screen-4.3.1.tar.gz'
  source_sha256 'fa4049f8aee283de62e283d427f2cfd35d6c369b40f7f45f947dbfd915699d63'

  depends_on 'ncurses'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

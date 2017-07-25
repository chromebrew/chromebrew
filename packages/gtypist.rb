require 'package'

class Gtypist < Package
  description 'Universal typing tutor.'
  homepage 'https://www.gnu.org/software/gtypist/index.html'
  version '2.9.5'
  source_url 'http://ftp.gnu.org/gnu/gtypist/gtypist-2.9.5.tar.xz'
  source_sha256 'c13af40b12479f8219ffa6c66020618c0ce305ad305590fde02d2c20eb9cf977'

  depends_on "emacs" => :build
  depends_on "ncurses"
  depends_on "perl"

  def self.build
    system "autoreconf"
    system "./configure", "--prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "prefix=#{CREW_DEST_DIR}/usr/local", "install"
    system "rm", "-f", "#{CREW_DEST_DIR}/usr/local/share/info/dir"
  end
end

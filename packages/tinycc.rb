require 'package'

class Tinycc < Package
  version '0.9.26'
  source_url 'http://download.savannah.gnu.org/releases/tinycc/tcc-0.9.26.tar.bz2'
  source_sha1 '7110354d3637d0e05f43a006364c897248aed5d0'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" 
  end
end

require 'package'

class Gzip < Package
  version '1.8'
  source_url 'http://ftp.gnu.org/gnu/gzip/gzip-1.8.tar.xz'
  source_sha1 '224bc2af5202eccf47f22357023d222011f9de78'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

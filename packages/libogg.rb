require 'package'

class Libogg < Package
  version '1.3.1'
  source_url 'http://downloads.xiph.org/releases/ogg/libogg-1.3.1.tar.xz'
  source_sha1 'a4242415a7a9fd71f3092af9ff0b9fa630e4d7bd'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

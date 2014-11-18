require 'package'

class Cmake < Package
  version '3.0.2'
  source_url 'http://www.cmake.org/files/v3.0/cmake-3.0.2.tar.gz'
  source_sha1 '379472e3578902a1d6f8b68a9987773151d6f21a'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

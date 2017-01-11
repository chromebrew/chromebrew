require 'package'

class Cmake < Package
  version '3.6.1'
  source_url 'https://cmake.org/files/v3.6/cmake-3.6.1.tar.gz'
  source_sha1 'a37785b3f256a31ee21a047569bc74a8f57067bb'

  depends_on 'buildessential'
  depends_on 'openssl'

  def self.build
    system "./bootstrap"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

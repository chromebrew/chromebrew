require 'package'

class Curl < Package
  version '7.52.1'
  source_url 'https://curl.haxx.se/download/curl-7.52.1.tar.bz2'
  source_sha1 'aa9f2300096d806c68c7ba8c50771853d1b43eb4'

  depends_on 'openssl' => :build
  depends_on 'zlibpkg' => :build
  depends_on 'libssh2'
  depends_on 'groff' => :build

  def self.build
    system "./configure", "--disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make test"
  end
end

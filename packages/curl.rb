require 'package'

class Curl < Package
  version '7.54.0'
  source_url 'https://curl.haxx.se/download/curl-7.54.0.tar.bz2'
  source_sha1 'e1cc251508e98bc5a8b9d5c40d8a4f6e48465d1c'

  depends_on 'openssl' => :build
  depends_on 'zlibpkg' => :build
  depends_on 'libssh2'
  depends_on 'groff' => :build

  def self.build
    system "./configure", "--disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"

    # strip debug symbol from library
    system "strip -S #{CREW_DEST_DIR}/usr/local/lib/libcurl.so.*"
  end

  def self.check
    system "make", "test"
  end
end

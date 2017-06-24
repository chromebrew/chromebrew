require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.haxx.se/'
  version '7.54.1'
  source_url 'https://curl.haxx.se/download/curl-7.54.1.tar.bz2'
  source_sha1 'f5193316e4b5ff23505cb09bc946763d35d02cd6'

  depends_on 'openssl' => :build
  depends_on 'zlibpkg' => :build
  depends_on 'libssh2'
  depends_on 'groff' => :build

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}", "--disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"

    # strip debug symbol from library
    system "strip -S #{CREW_DEST_DIR}#{CREW_LIB_PREFIX}/libcurl.so.*"
  end

  def self.check
    system "make", "test"
  end
end

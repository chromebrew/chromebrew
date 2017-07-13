require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.haxx.se/'
  version '7.54.1'
  source_url 'https://curl.haxx.se/download/curl-7.54.1.tar.bz2'
  source_sha256 'fdfc4df2d001ee0c44ec071186e770046249263c491fcae48df0e1a3ca8f25a0'

  depends_on 'openssl' => :build
  depends_on 'zlibpkg' => :build
  depends_on 'libssh2'
  depends_on 'groff' => :build

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}", "--disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "test"
  end
end

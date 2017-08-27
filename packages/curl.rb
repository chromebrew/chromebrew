require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.haxx.se/'
  version '7.55.1'
  source_url 'https://curl.haxx.se/download/curl-7.55.1.tar.bz2'
  source_sha256 'e5b1a92ed3b0c11f149886458fa063419500819f1610c020d62f25b8e4b16cfb'

  binary_url ({
  })
  binary_sha256 ({
  })

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

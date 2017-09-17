require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.haxx.se/'
  version '7.55.1'
  source_url 'https://curl.haxx.se/download/curl-7.55.1.tar.bz2'
  source_sha256 'e5b1a92ed3b0c11f149886458fa063419500819f1610c020d62f25b8e4b16cfb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.55.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.55.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.55.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.55.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7ef956dad600af8a22681f2d03360b88900ced7f27d3515904ef3f9aac47685e',
     armv7l: '7ef956dad600af8a22681f2d03360b88900ced7f27d3515904ef3f9aac47685e',
       i686: '85e4c5086ff52f3c0e86db39fc23cf9fc942ebc2acfeb34cb9c02a59d1d7ad85',
     x86_64: 'a033d6ed5133d8f0e6e6f76a38b2e4b6fb241803d21ff0b593e11d5a9481ed3c',
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

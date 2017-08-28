require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.haxx.se/'
  version '7.54.1'
  source_url 'https://curl.haxx.se/download/curl-7.54.1.tar.bz2'
  source_sha256 'fdfc4df2d001ee0c44ec071186e770046249263c491fcae48df0e1a3ca8f25a0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.54.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.54.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.54.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.54.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'daccab6923899c4a39479689051ab4842ba5a90c88cd0f8d360902db685e0698',
     armv7l: 'daccab6923899c4a39479689051ab4842ba5a90c88cd0f8d360902db685e0698',
       i686: '0132bc64633d7407c1551972bcdad0227c109ad79afd9e75bb041ddc13897ba6',
     x86_64: '5770fa2afa9d6c9b34c911752a50a799de3f6c3a00a5934e7a8d7967a2868e55',
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

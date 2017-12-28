require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.haxx.se/'
  version '7.57.0-1'
  source_url 'https://curl.haxx.se/download/curl-7.57.0.tar.xz'
  source_sha256 'f5f6fd3c72b7b8389969f4fb671ed8532fa9b5bb7a5cae7ca89bc1cea45c7878'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.57.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.57.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.57.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.57.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1805db33717f18a38933f6bc13e4135856c5576a4501797aefba5f05714cbca5',
     armv7l: '1805db33717f18a38933f6bc13e4135856c5576a4501797aefba5f05714cbca5',
       i686: '1ae5e21dab5a93a3a6f49981b33f035ee5e7226d0f92ad15c085ec3c2bb99f6d',
     x86_64: '7dec09c121ac5f7028e43e88cf20214d8d3b358c1fe097ef9e4ba0d924816b25',
  })

  depends_on 'groff' => :build
  depends_on 'libssh2'
  depends_on 'openssl'
  depends_on 'rtmpdump'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--disable-debug',
      '--disable-dependency-tracking',
      '--disable-static'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'test'
  end
end

require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.haxx.se/'
  version '7.59.0'
  source_url 'https://curl.haxx.se/download/curl-7.59.0.tar.xz'
  source_sha256 'e44eaabdf916407585bf5c7939ff1161e6242b6b015d3f2f5b758b2a330461fc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.59.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.59.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.59.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.59.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f4e2c9f252ab2ec8b017ca7cc2232119cb82d032815365ba3ca7887505b0bb11',
     armv7l: 'f4e2c9f252ab2ec8b017ca7cc2232119cb82d032815365ba3ca7887505b0bb11',
       i686: '6d02fa76384f3750de4d3e670fb42054b0042746a8cc88746d3114c394390798',
     x86_64: '1d0d949a5b56638e049ce6959b48007653df9f50bdadd3cf0d6f68d90b24667b',
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

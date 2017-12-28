require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.haxx.se/'
  version '7.57.0-1'
  source_url 'https://curl.haxx.se/download/curl-7.57.0.tar.xz'
  source_sha256 'f5f6fd3c72b7b8389969f4fb671ed8532fa9b5bb7a5cae7ca89bc1cea45c7878'

  binary_url ({
  })
  binary_sha256 ({
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

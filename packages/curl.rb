require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.haxx.se/'
  version '7.56.0'
  source_url 'https://curl.haxx.se/download/curl-7.56.0.tar.xz'
  source_sha256 '32437bcca0e9434384329fdc733547879d25ba70335b3cf9e3d9cbc3e71fd172'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'groff' => :build
  depends_on 'libssh2'
  depends_on 'openssl' => :build
  depends_on 'zlibpkg' => :build

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

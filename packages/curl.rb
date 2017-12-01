require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.haxx.se/'
  version '7.57.0'
  source_url 'https://curl.haxx.se/download/curl-7.57.0.tar.xz'
  source_sha256 'f5f6fd3c72b7b8389969f4fb671ed8532fa9b5bb7a5cae7ca89bc1cea45c7878'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.57.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.57.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.57.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.57.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '73f890553e733f4ad71db78ecc9a80e1e608b13b49faf03ef0a0066ee53bf679',
     armv7l: '73f890553e733f4ad71db78ecc9a80e1e608b13b49faf03ef0a0066ee53bf679',
       i686: 'a9a2eaf1560e3480f0d9b2e09f9e5b5a0a92f986d6ed971665d44ff28a299e67',
     x86_64: 'c9981942058ad8a0d0556df4431e7cfe409f1c37b22e5a1406224ccda7ca5b52',
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

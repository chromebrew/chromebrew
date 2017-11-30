require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.haxx.se/'
  version '7.56.1'
  source_url 'https://curl.haxx.se/download/curl-7.56.1.tar.xz'
  source_sha256 '8eed282cf3a0158d567a0feaa3c4619e8e847970597b5a2c81879e8f0d1a39d1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.56.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.56.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.56.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.56.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7b2e42aa02044eb77dc45cc74657a26e937f02829ad396dd28f18fa5116ad57c',
     armv7l: '7b2e42aa02044eb77dc45cc74657a26e937f02829ad396dd28f18fa5116ad57c',
       i686: '40f88fd927b1722715b155310a85421fd72540594aa9ff4ad2f08d730562d71c',
     x86_64: '082dc3d26e7ffbd76486ed929246ff599e6b18e8daa2737778455bdcc2653915',
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

require 'package'

class Apr < Package
  description 'The mission of the Apache Portable Runtime (APR) project is to create and maintain software libraries that provide a predictable and consistent interface to underlying platform-specific implementations.  APR is the base portability library.'
  homepage 'http://apr.apache.org/'
  version '1.6.3'
  source_url 'https://apache.claz.org/apr/apr-1.6.3.tar.bz2'
  source_sha256 '131f06d16d7aabd097fa992a33eec2b6af3962f93e6d570a9bd4d85e95993172'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/apr-1.6.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/apr-1.6.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/apr-1.6.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/apr-1.6.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6792f3be82153a55571005b4e61e971fc49e4cefcc3f77f8fe91433450efa91b',
     armv7l: '6792f3be82153a55571005b4e61e971fc49e4cefcc3f77f8fe91433450efa91b',
       i686: '11f1b82c2837e841bb02daa0e281d15130b3bec060c673c5d6175038689d2eee',
     x86_64: 'c22341487a85273be410903c4ef4dfef849e4a01815f974aa23346a7488ea568',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

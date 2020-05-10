require 'package'

class Apr < Package
  description 'The mission of the Apache Portable Runtime (APR) project is to create and maintain software libraries that provide a predictable and consistent interface to underlying platform-specific implementations.  APR is the base portability library.'
  homepage 'https://apr.apache.org/'
  version '1.7.0'
  compatibility 'all'
  source_url 'https://apache.claz.org/apr/apr-1.7.0.tar.bz2'
  source_sha256 'e2e148f0b2e99b8e5c6caa09f6d4fb4dd3e83f744aa72a952f94f5a14436f7ea'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/apr-1.7.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/apr-1.7.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/apr-1.7.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/apr-1.7.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd69034b2a36311d738e752c3a7c8b07aa91e8b2e49672e0dbb6ecb684edd4013',
     armv7l: 'd69034b2a36311d738e752c3a7c8b07aa91e8b2e49672e0dbb6ecb684edd4013',
       i686: '9bdd86a0e68b90df6ac97df2cb71ef3329e0f90e9300041ae4ce7104acc9a478',
     x86_64: 'dbbc258584c51eb6138e6f39f0106bdf9aa26ad9c65df2d2fba80931f7027507',
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

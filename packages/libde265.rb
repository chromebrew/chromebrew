require 'package'

class Libde265 < Package
  description 'Open h.265 video codec implementation.'
  homepage 'https://github.com/strukturag/libde265'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://github.com/strukturag/libde265/releases/download/v1.0.3/libde265-1.0.3.tar.gz'
  source_sha256 'e4206185a7c67d3b797d6537df8dcaa6e5fd5a5f93bd14e65a755c33cd645f7a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libde265-1.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libde265-1.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libde265-1.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libde265-1.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '851a496c32ead6b6da9cf6f1ec14ae991f47592d400fa714151cf72552a4a58d',
     armv7l: '851a496c32ead6b6da9cf6f1ec14ae991f47592d400fa714151cf72552a4a58d',
       i686: '8a70ce6f43f78f6edba1f50e47cd17956ee21d92c534454785de4f143d3a5775',
     x86_64: '0833d3f548c83b9706fe7a8797f0b695c907fac1f2aebbbabb936d0aea440f8a',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-dependency-tracking'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

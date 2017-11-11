require 'package'

class Apr < Package
  description 'The mission of the Apache Portable Runtime (APR) project is to create and maintain software libraries that provide a predictable and consistent interface to underlying platform-specific implementations.  APR is the base portability library.'
  homepage 'http://apr.apache.org/'
  version '1.6.3'
  source_url 'https://apache.claz.org/apr/apr-1.6.3.tar.bz2'
  source_sha256 '131f06d16d7aabd097fa992a33eec2b6af3962f93e6d570a9bd4d85e95993172'

  binary_url ({
  })
  binary_sha256 ({
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

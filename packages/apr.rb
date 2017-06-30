require 'package'

class Apr < Package
  description 'The mission of the Apache Portable Runtime (APR) project is to create and maintain software libraries that provide a predictable and consistent interface to underlying platform-specific implementations.  APR is the base portability library.'
  homepage 'http://apr.apache.org/'
  version '1.5.2'
  source_url 'http://apache.claz.org/apr/apr-1.5.2.tar.bz2'
  source_sha256 '7d03ed29c22a7152be45b8e50431063736df9e1daa1ddf93f6a547ba7a28f67a'

  depends_on 'buildessential'

  def self.build
    system './configure --prefix=/usr/local'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

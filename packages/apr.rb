require 'package'

class Apr < Package
  description 'The mission of the Apache Portable Runtime (APR) project is to create and maintain software libraries that provide a predictable and consistent interface to underlying platform-specific implementations.  APR is the base portability library.'
  homepage 'http://apr.apache.org/'
  version '1.5.2'
  source_url 'http://apache.claz.org/apr/apr-1.5.2.tar.bz2'
  source_sha1 '6d757fcf7c687fc300c1066076f2e8380ff8cbc0'

  depends_on 'buildessential'

  def self.build
    system './configure --prefix=/usr/local'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

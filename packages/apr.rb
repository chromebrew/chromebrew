require 'package'

class Apr < Package
  description 'The mission of the Apache Portable Runtime (APR) project is to create and maintain software libraries that provide a predictable and consistent interface to underlying platform-specific implementations.  APR is the base portability library.'
  homepage 'http://apr.apache.org/'
  version '1.6.2'
  source_url 'http://apache.claz.org/apr/apr-1.6.2.tar.bz2'
  source_sha256 '09109cea377bab0028bba19a92b5b0e89603df9eab05c0f7dbd4dd83d48dcebd'

  depends_on 'buildessential'

  def self.build
    system './configure --prefix=/usr/local'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

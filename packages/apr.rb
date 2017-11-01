require 'package'

class Apr < Package
  description 'The mission of the Apache Portable Runtime (APR) project is to create and maintain software libraries that provide a predictable and consistent interface to underlying platform-specific implementations.  APR is the base portability library.'
  homepage 'http://apr.apache.org/'
  version '1.6.2'
  source_url 'http://apache.claz.org/apr/apr-1.6.2.tar.bz2'
  source_sha256 '09109cea377bab0028bba19a92b5b0e89603df9eab05c0f7dbd4dd83d48dcebd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/apr-1.6.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/apr-1.6.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/apr-1.6.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/apr-1.6.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e93f070e23ec7c8e80646d69c1d3c03444d6317562f5856077ef599c8eddd03c',
     armv7l: 'e93f070e23ec7c8e80646d69c1d3c03444d6317562f5856077ef599c8eddd03c',
       i686: '865b7ff09833786362ee2846a35cda6d8df7e6bafbc505adbbcd16decf98481f',
     x86_64: '2c1a686695dcb949a72b99c2ff75f12dde2ef7dcad531ba7d3ede0abcd004f06',
  })

  depends_on 'buildessential'

  def self.build
    system './configure --prefix=/usr/local'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

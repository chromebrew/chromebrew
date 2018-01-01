require 'package'

class Bind < Package
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/downloads/bind/'
  version '9.11.2'
  source_url 'https://ftp.isc.org/isc/bind9/9.11.2/bind-9.11.2.tar.gz'
  source_sha256 '7f46ad8620f7c3b0ac375d7a5211b15677708fda84ce25d7aeb7222fe2e3c77a'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on "buildessential"
  depends_on "openssl"
  depends_on "libcap"
  depends_on "readline"
  depends_on "diffutils"

  def self.build
    system "BUILD_CC=gcc ./configure --with-randomdev=no --with-ecdsa=yes --with-gost=yes --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end

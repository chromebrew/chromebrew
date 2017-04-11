require 'package'

class Bind < Package
  version '9.10.4'
  source_url 'https://www.isc.org/downloads/file/bind-9-10-4-p6/'
  source_sha1 'c08bef47136b3b88844a4c3b8a6227445fca6f40'

  depends_on "buildessential"
  depends_on "openssl"
  depends_on "libcap"
  depends_on "readline"

  def self.build
    system "BUILD_CC=gcc ./configure --with-randomdev=no --with-ecdsa=yes --with-gost=yes --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

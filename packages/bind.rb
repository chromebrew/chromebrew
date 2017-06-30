require 'package'

class Bind < Package
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/downloads/bind/'
  version '9.10.4'
  source_url 'https://www.isc.org/downloads/file/bind-9-10-4-p6/'
  source_sha256 'a1dfbfd1d11cb52f2d9e5af0def25763798bda243841722dd0b319086a73ee65'

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

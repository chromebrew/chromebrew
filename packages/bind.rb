require 'package'

class Bind < Package
  description 'BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users.'
  homepage 'https://www.isc.org/downloads/bind/'
  version '9.10.5-p3'
  source_url 'https://www.isc.org/downloads/file/9-10-5-p3/?version=tar-gz'
  source_sha256 '8d7e96b5b0bbac7b900d4c4bbb82e0956b4e509433c5fa392bb72a929b96606a'

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

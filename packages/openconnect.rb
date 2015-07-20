require 'package'

class Openconnect < Package
  version '7.06'
  source_url 'ftp://ftp.infradead.org/pub/openconnect/openconnect-7.06.tar.gz'
  source_sha1 '2351408693aab0c6bc97d37e68b4a869fbb217ed'

  def self.build
    system "./configure --libdir=/usr/local/lib64/ CC=\"gcc -m64\" CFLAGS=\" -fPIC\" --without-gnutls"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

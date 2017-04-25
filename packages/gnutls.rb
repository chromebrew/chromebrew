require 'package'

class Gnutls < Package
  version '3.5.8'
  source_url 'ftp://ftp.gnutls.org/gcrypt/gnutls/v3.5/gnutls-3.5.8.tar.xz'
  source_sha1 '238d5e62f9bb078101131dd2f4c7f2c1ac13e813'

  depends_on 'buildessential'
  depends_on 'nettle'
  depends_on 'pkgconfig'
  depends_on 'libtasn1'
  depends_on 'trousers'
  depends_on 'p11kit'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

require 'package'

class Gnutls < Package
  description 'GnuTLS is a secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them.'
  homepage 'http://gnutls.org/'
  version '3.5.12'
  source_url 'https://www.gnupg.org/ftp/gcrypt/gnutls/v3.5/gnutls-3.5.12.tar.xz'
  source_sha256 '63cb39a5eaa029381df2e49a74cfb7be89fc4a592445191818ffe1e66bde57cb'

  depends_on 'buildessential' => :build
  depends_on 'zlibpkg' => :build
  depends_on 'libunistring'
  depends_on 'gmp'
  depends_on 'nettle'
  depends_on 'pkgconfig' => :build
  depends_on 'libtasn1'
  depends_on 'trousers'
  depends_on 'p11kit'
  depends_on 'libffi'
  depends_on 'libunbound'

  def self.build
    system "./configure", "--enable-shared", "--disable-static", "--with-pic",
      "--with-system-priority-file=#{CREW_PREFIX}/etc/gnutls/default-priorities",
      "--with-unbound-root-key-file=#{CREW_PREFIX}/etc/unbound/root.key"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make check"
  end
end

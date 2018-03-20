require 'package'

class Gnutls < Package
  description 'GnuTLS is a secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them.'
  homepage 'http://gnutls.org/'
  version '3.6.0'
  source_url 'https://www.gnupg.org/ftp/gcrypt/gnutls/v3.6/gnutls-3.6.0.tar.xz'
  source_sha256 '2ab9e3c0131fcd9142382f37ba9c6d20022b76cba83560cbcaa8e4002d71fb72'

  depends_on 'buildessential' => :build
  depends_on 'zlibpkg'
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
    system "./configure", "--enable-shared", "--disable-static", "--with-pic", "--with-guile-site-dir=no",
      "--with-system-priority-file=#{CREW_PREFIX}/etc/gnutls/default-priorities",
      "--with-unbound-root-key-file=#{CREW_PREFIX}/etc/unbound/root.key",
      "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make check"
  end
end

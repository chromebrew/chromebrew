require 'package'

class Gnutls < Package
  description 'GnuTLS is a secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them.'
  homepage 'http://gnutls.org/'
  version '3.6.3'
  source_url 'https://www.gnupg.org/ftp/gcrypt/gnutls/v3.6/gnutls-3.6.3.tar.xz'
  source_sha256 'ed642b66a4ecf4851ab2d809cd1475c297b6201d8e8bd14b4d1c08b53ffca993'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.6.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.6.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.6.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.6.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2534f0e4e6ccfd51f536d8941ee366250a520233dec514df0a7069eee8c9cea4',
     armv7l: '2534f0e4e6ccfd51f536d8941ee366250a520233dec514df0a7069eee8c9cea4',
       i686: '94f26d89d7cd24fbadafa539ccdb60ef2cc7ddb5bacccfdafdea367bd3cb5bca',
     x86_64: 'f4973935b8bfde5225b3d58a90a0f64d0676303f0eb8f2c7cb8d8aff3f62e51a',
  })

  depends_on 'zlibpkg'
  depends_on 'libunistring'
  depends_on 'gmp'
  depends_on 'nettle'
  depends_on 'libtasn1'
  depends_on 'trousers'
  depends_on 'p11kit'
  depends_on 'libffi'
  depends_on 'libunbound'
  depends_on 'libidn2'

  def self.build
    system "./configure", "--enable-shared", "--disable-static", "--with-pic",
      "--with-system-priority-file=#{CREW_PREFIX}/etc/gnutls/default-priorities",
      "--with-unbound-root-key-file=#{CREW_PREFIX}/etc/unbound/root.key",
      "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    #system "make", "check"
  end
end

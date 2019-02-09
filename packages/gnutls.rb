require 'package'

class Gnutls < Package
  description 'GnuTLS is a secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them.'
  homepage 'http://gnutls.org/'
  version '3.6.3-1'
  source_url 'https://www.gnupg.org/ftp/gcrypt/gnutls/v3.6/gnutls-3.6.3.tar.xz'
  source_sha256 'ed642b66a4ecf4851ab2d809cd1475c297b6201d8e8bd14b4d1c08b53ffca993'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.6.3-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.6.3-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.6.3-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.6.3-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7b8f451dcc136eafc149196998494173200d4c0e6e44484c6cdedfaccb1e32fe',
     armv7l: '7b8f451dcc136eafc149196998494173200d4c0e6e44484c6cdedfaccb1e32fe',
       i686: 'b23d185954cb6e28ff20918a54ce573700686e25193d2921acb18dd017d629ba',
     x86_64: '70a7b1753ab61e09249f599bbad21e16e8eff71848787c8ad4e77c90582a6f1b',
  })

  depends_on 'libz'
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

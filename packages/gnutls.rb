require 'package'

class Gnutls < Package
  description 'GnuTLS is a secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them.'
  homepage 'http://gnutls.org/'
  version '3.5.15'
  source_url 'https://www.gnupg.org/ftp/gcrypt/gnutls/v3.5/gnutls-3.5.15.tar.xz'
  source_sha256 '046081108b8b1fe455a13a4c5a4eaa0368e185b678f1670fe09a11a2d7ecfad5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.5.15-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.5.15-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.5.15-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.5.15-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3c9183dae47b19d037204b5bf1e3fb142ac88cd7a3ee2e24f2e22c9e414dd0a2',
     armv7l: '3c9183dae47b19d037204b5bf1e3fb142ac88cd7a3ee2e24f2e22c9e414dd0a2',
       i686: '71f725c3c414f203bdc2a9b7deea04ef655b12c8f28b0d7febfac09a1f688c88',
     x86_64: '1a09cd1e743e08254bec0b1d60b00ac89bcf210af98c98734aa68d36f79d7c7a',
  })

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

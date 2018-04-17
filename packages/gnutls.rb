require 'package'

class Gnutls < Package
  description 'GnuTLS is a secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them.'
  homepage 'http://gnutls.org/'
  version '3.6.2'
  source_url 'https://www.gnupg.org/ftp/gcrypt/gnutls/v3.6/gnutls-3.6.2.tar.xz'
  source_sha256 'bcd5db7b234e02267f36b5d13cf5214baac232b7056a506252b7574ea7738d1f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.6.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.6.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.6.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.6.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '18407ecd4cd634a74e93c07f0ace40a3e62bc2b85ce45c9b3ecac5ef068769d5',
     armv7l: '18407ecd4cd634a74e93c07f0ace40a3e62bc2b85ce45c9b3ecac5ef068769d5',
       i686: 'e49286dc9b7a740c2281a750c8e66ce9390d2e1887da574992de4f33fb61f372',
     x86_64: '119494bbb371d74538696b1ffae01bae736824db16ac58ad1c4e05cf35dc6e36',
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
    system "make", "check"
  end
end

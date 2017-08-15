require 'package'

class Gnutls < Package
  description 'GnuTLS is a secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them.'
  homepage 'http://gnutls.org/'
  version '3.5.14-1'
  source_url 'https://www.gnupg.org/ftp/gcrypt/gnutls/v3.5/gnutls-3.5.14.tar.xz'
  source_sha256 '4aa12dec92f42a0434df794aca3d02f6f2a35b47b48c01252de65f355c051bda'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/gnutls-3.5.14-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/gnutls-3.5.14-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/gnutls-3.5.14-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/gnutls-3.5.14-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9f49294e0e5896de387c29789df95c9b8d777025664c9a4fbe8f181101f6a92f',
     armv7l: '9f49294e0e5896de387c29789df95c9b8d777025664c9a4fbe8f181101f6a92f',
       i686: 'ba541aa4791bb15fba3b33ed3d884e1bf689027fb85c115d73f70b8894789554',
     x86_64: 'fea2972759a7846dad494bb8a56e14d3b5378c4707bcb16c356e737193d40cfc',
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

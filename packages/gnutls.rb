require 'package'

class Gnutls < Package
  description 'GnuTLS is a secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them.'
  homepage 'http://gnutls.org/'
  version '3.7.0-1'
  compatibility 'all'
  source_url 'https://www.gnupg.org/ftp/gcrypt/gnutls/v3.7/gnutls-3.7.0.tar.xz'
  source_sha256 '49e2a22691d252c9f24a9829b293a8f359095bc5a818351f05f1c0a5188a1df8'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.7.0-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.7.0-1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.7.0-1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.7.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '7a80e48b97bb721ee3b6805d5863d61800a230c9b598a511a07df3af5d49dfdb',
      armv7l: '7a80e48b97bb721ee3b6805d5863d61800a230c9b598a511a07df3af5d49dfdb',
        i686: 'b3f8597ad7173e9721bd5bc5dbb6fd6385fac9cc748fc7e5d1871dc7161ccff8',
      x86_64: 'd9fb0a59c22d64d629a7fcd868450b0c862a2bbe66c8940d854331da738ba4c3',
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
    system "./configure --help"
    system "env CFLAGS='-flto=1' CXXFLAGS='-flto=1' \
    ./configure #{CREW_OPTIONS} \
    --enable-shared \
    --with-pic \
    --with-system-priority-file=#{CREW_PREFIX}/etc/gnutls/default-priorities \
    --with-unbound-root-key-file=#{CREW_PREFIX}/etc/unbound/root.key"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    #system "make", "check"
  end
end

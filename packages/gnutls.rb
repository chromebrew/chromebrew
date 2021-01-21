require 'package'

class Gnutls < Package
  description 'GnuTLS is a secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them.'
  homepage 'http://gnutls.org/'
  version '3.7.0'
  compatibility 'all'
  source_url 'https://www.gnupg.org/ftp/gcrypt/gnutls/v3.7/gnutls-3.7.0.tar.xz'
  source_sha256 '49e2a22691d252c9f24a9829b293a8f359095bc5a818351f05f1c0a5188a1df8'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.7.0-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.7.0-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.7.0-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.7.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '4e7f7e7314732e4716817f541e408a76489a53a9bb3b98e0c4072bb290c50cf5',
      armv7l: '4e7f7e7314732e4716817f541e408a76489a53a9bb3b98e0c4072bb290c50cf5',
        i686: 'c3ebd7f90ca13365f208afd7384f6979de959c38fd7cc2ea780b4f951e743b36',
      x86_64: '74ede0950a89488bf91cc9e144f7318d8e26b4a522d50db557f182cef66ced39',
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

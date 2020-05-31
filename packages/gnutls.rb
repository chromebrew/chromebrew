require 'package'

class Gnutls < Package
  description 'GnuTLS is a secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them.'
  homepage 'http://gnutls.org/'
  version '3.6.12'
  source_url 'https://www.gnupg.org/ftp/gcrypt/gnutls/v3.6/gnutls-3.6.12.tar.xz'
  source_sha256 'bfacf16e342949ffd977a9232556092c47164bd26e166736cf3459a870506c4b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.6.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.6.12-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.6.12-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnutls-3.6.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ef7aac519396162958750c83622781f8f9e4c30cee06b911271a8ae3d8cb44a4',
     armv7l: 'ef7aac519396162958750c83622781f8f9e4c30cee06b911271a8ae3d8cb44a4',
       i686: 'd403e4200b18dfafba3c46bdf3c95e3e59088499b8fae5e22085f65b8a99fc49',
     x86_64: '261a3766026d916bdb4a68fd1b55a9409e52ac06e2949310371bf9a13dea3751',
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

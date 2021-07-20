require 'package'

class Gnutls < Package
  description 'GnuTLS is a secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them.'
  homepage 'http://gnutls.org/'
  version '3.7.2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://www.gnupg.org/ftp/gcrypt/gnutls/v3.7/gnutls-3.7.2.tar.xz'
  source_sha256 '646e6c5a9a185faa4cea796d378a1ba8e1148dbb197ca6605f95986a25af2752'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnutls/3.7.2_armv7l/gnutls-3.7.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnutls/3.7.2_armv7l/gnutls-3.7.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnutls/3.7.2_i686/gnutls-3.7.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnutls/3.7.2_x86_64/gnutls-3.7.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '610e93e9f684b6e0dcac110ad323f0f4037e5d464968788e8686fe8328c63d4f',
     armv7l: '610e93e9f684b6e0dcac110ad323f0f4037e5d464968788e8686fe8328c63d4f',
       i686: '7849bf00eadd86e4eaead29de780b446aea8da21524221c4a98fc39532e5673f',
     x86_64: '6570141b5100fee1bf0bf75012beea7b641bec5a0d79c131d22f2b20b042008a'
  })

  depends_on 'zlibpkg'
  depends_on 'libunistring'
  depends_on 'gmp'
  depends_on 'nettle'
  depends_on 'libtasn1'
  depends_on 'trousers'
  depends_on 'p11kit' # This package cannot be built statically.
  depends_on 'libffi'
  depends_on 'libunbound'
  depends_on 'libidn2'

  def self.prebuild
    # Use IPv4 fallback if default connection fails.
    system "#{CREW_PREFIX}/sbin/unbound-anchor -a '#{CREW_PREFIX}/etc/unbound/root.key' || #{CREW_PREFIX}/sbin/unbound-anchor -4 -a '#{CREW_PREFIX}/etc/unbound/root.key'"
  end

  def self.patch
    system 'filefix'
  end

  def self.build
    system './configure --help'
    system "./configure #{CREW_OPTIONS} #{CREW_ENV_OPTIONS} \
      --enable-shared \
      --enable-static \
      --with-pic \
      --with-system-priority-file=#{CREW_PREFIX}/etc/gnutls/default-priorities \
      --with-trousers-lib=#{CREW_LIB_PREFIX}/libtspi.so.1 \
      --with-unbound-root-key-file=#{CREW_PREFIX}/etc/unbound/root.key"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system "make", "check"
  end
end

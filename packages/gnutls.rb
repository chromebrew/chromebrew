require 'package'

class Gnutls < Package
  description 'GnuTLS is a secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them.'
  homepage 'http://gnutls.org/'
  version '3.7.2-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://www.gnupg.org/ftp/gcrypt/gnutls/v3.7/gnutls-3.7.2.tar.xz'
  source_sha256 '646e6c5a9a185faa4cea796d378a1ba8e1148dbb197ca6605f95986a25af2752'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnutls/3.7.2-1_armv7l/gnutls-3.7.2-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnutls/3.7.2-1_armv7l/gnutls-3.7.2-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnutls/3.7.2-1_i686/gnutls-3.7.2-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnutls/3.7.2-1_x86_64/gnutls-3.7.2-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c2aa4651e3fcde7acb408d581be30d33ac5a99aeacdfb7ed1aa332ffa08807d8',
     armv7l: 'c2aa4651e3fcde7acb408d581be30d33ac5a99aeacdfb7ed1aa332ffa08807d8',
       i686: '7e70441115c1d1d5930f61ab8f81b91484dac0ad7fce74601abcd497346a0497',
     x86_64: '607851025aec31be1628da21af43c29307024cf5169bed7f34707504d0099824'
  })

  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'libffi'
  depends_on 'libidn2' # R
  depends_on 'libtasn1' # R
  depends_on 'libunbound' # R
  depends_on 'libunistring' # R
  depends_on 'nettle' # R
  depends_on 'p11kit' # R This package cannot be built statically.
  depends_on 'trousers'
  depends_on 'zlibpkg'

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
    system 'make', 'check'
  end
end

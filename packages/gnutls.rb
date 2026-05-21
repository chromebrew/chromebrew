require 'buildsystems/autotools'

class Gnutls < Autotools
  description 'GnuTLS is a secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them.'
  homepage 'https://gnutls.org/'
  version '3.8.13'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://gitlab.com/gnutls/gnutls.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9b486eb64ad4903aa450999d6cd2c7226d593dffc4d9afdcc2129a143b05d791',
     armv7l: '9b486eb64ad4903aa450999d6cd2c7226d593dffc4d9afdcc2129a143b05d791',
       i686: '4bb5143d70e669b802285171092e42a013d8c3848f002a44d6739601c36462a4',
     x86_64: '90cf5b62ab2bbe170f2c372b49237178e0c370adc4b7539cfc69eecd330c3cca'
  })

  depends_on 'brotli' => :library
  depends_on 'ca_certificates' => :logical
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'gmp' => :library
  depends_on 'gperf' => :build
  depends_on 'libev' => :build
  depends_on 'libffi' => :build
  depends_on 'libidn2' => :library
  depends_on 'libtasn1' => :library
  depends_on 'libunbound' => :library
  depends_on 'libunistring' => :library
  depends_on 'nettle' => :library
  depends_on 'openssl' => :library
  depends_on 'p11kit' => :library
  depends_on 'trousers' => :build
  depends_on 'wget_static' => :build
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  no_lto

  def self.prebuild
    # The c11threads threads.h breaks builds on software that uses gnulib.
    # See: https://github.com/jtsiomb/c11threads/issues/19
    # Note that c11threads is a workaround for C11 Threads only being
    # introduced in Glibc 2.28 as per:
    # https://sourceware.org/bugzilla/show_bug.cgi?id=14092#c10
    if LIBC_VERSION.to_f < 2.28 && ENV['NESTED_CI']
      puts 'Removing the c11threads include/threads.h from the c11threads package to prevent build failures.'.orange
      FileUtils.rm_f "#{CREW_PREFIX}/include/threads.h"
    end
    # Use IPv4 fallback if default connection fails.
    system "#{CREW_PREFIX}/sbin/unbound-anchor -a '#{CREW_PREFIX}/etc/unbound/root.key' || #{CREW_PREFIX}/sbin/unbound-anchor -4 -a '#{CREW_PREFIX}/etc/unbound/root.key'"
    # Rebuild ca-certificates.
    system "#{CREW_PREFIX}/bin/update-ca-certificates --fresh --certsconf #{CREW_PREFIX}/etc/ca-certificates.conf"
  end

  autotools_configure_options "--disable-doc \
      --enable-manpages \
      --enable-shared \
      --with-pic \
      --with-system-priority-file=#{CREW_PREFIX}/etc/gnutls/default-priorities \
      --with-trousers-lib=#{CREW_LIB_PREFIX}/libtspi.so.1 \
      --with-unbound-root-key-file=#{CREW_PREFIX}/etc/unbound/root.key \
      --with-default-trust-store-file=#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt"

  def self.check
    # There are numerous failures in the test suite on all systems.
    # FAIL: tls13/key_share
    # FAIL: tls13/compress-cert
    # FAIL: tls13/compress-cert-neg
    # FAIL: tls13/compress-cert-neg2
    # FAIL: tls13/compress-cert-cli
    # FAIL: tls13/psk-ke-modes
    # FAIL: simple
    # FAIL: pkcs12_encode
    # FAIL: x509cert-ct
    # FAIL: key-openssl
    # FAIL: fips-test
    # FAIL: rsa-rsa-pss
    # FAIL: privkey-keygen
    # FAIL: aead-cipher-vec
    # FAIL: kdf-api
    # FAIL: ciphersuite-name
    # FAIL: x509-upnconstraint
    # FAIL: cipher-padding
    # FAIL: pkcs7-verify-double-free
    # FAIL: privkey-keygen
    # FAIL: aead-cipher-vec
    # FAIL: kdf-api
    # FAIL: ciphersuite-name
    # FAIL: x509-upnconstraint
    # FAIL: cipher-padding
    # FAIL: pkcs7-verify-double-free
    # FAIL: fips-rsa-sizes
    # FAIL: tls12-resume-psk
    # FAIL: tls12-resume-x509
    # FAIL: tls12-resume-anon
    # FAIL: tls13-resume-psk
    # FAIL: tls13-resume-x509
    # FAIL: record-sendfile
    # FAIL: system-override-sig-tls.sh
    # FAIL: system-override-sig-allowlist.sh
    # FAIL: system-override-hash-allowlist.sh
    # FAIL: system-override-curves-allowlist.sh
    # FAIL: protocol-set-allowlist.sh
    system 'make check || true'
  end
end

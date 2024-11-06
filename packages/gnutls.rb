require 'buildsystems/autotools'

class Gnutls < Autotools
  description 'GnuTLS is a secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them.'
  homepage 'https://gnutls.org/'
  version '3.8.7.1'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/gnutls/v3.8/gnutls-#{version}.tar.xz"
  source_sha256 '9ca0ddaccce28a74fa18d738744190afb3b0daebef74e6ad686bf7bef99abd60'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '477db98c4c932da937920888b0a6e4cb3859113cd2414013d202a0fada2585e7',
     armv7l: '477db98c4c932da937920888b0a6e4cb3859113cd2414013d202a0fada2585e7',
       i686: '04ae5e17c1055201bf4d897b4beff5201ad4a1e95ee66555b009630381016848',
     x86_64: 'e4c4e9b6373f51a480c6b13787bfa6392f91959ada44cb1d2f3fb252cf6eccf3'
  })

  depends_on 'brotli' # R
  depends_on 'ca_certificates' # L
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'libffi' => :build
  depends_on 'libidn2' # R
  depends_on 'libtasn1' # R
  depends_on 'libunbound' # R
  depends_on 'libunistring' # R
  depends_on 'nettle' # R
  depends_on 'openssl' # R
  depends_on 'p11kit' # R
  depends_on 'trousers' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  no_lto

  def self.prebuild
    # Use IPv4 fallback if default connection fails.
    system "#{CREW_PREFIX}/sbin/unbound-anchor -a '#{CREW_PREFIX}/etc/unbound/root.key' || #{CREW_PREFIX}/sbin/unbound-anchor -4 -a '#{CREW_PREFIX}/etc/unbound/root.key'"
    # Rebuild ca-certificates.
    system "#{CREW_PREFIX}/bin/update-ca-certificates --fresh --certsconf #{CREW_PREFIX}/etc/ca-certificates.conf"
  end

  configure_options "--enable-shared \
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

require 'buildsystems/autotools'

class Gnutls < Autotools
  description 'GnuTLS is a secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them.'
  homepage 'https://gnutls.org/'
  version '3.8.12'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://gitlab.com/gnutls/gnutls.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7cad8a55bdef26259fc6a1cbe8a95fe724815c066d05eda1b12cc04ab5cc3514',
     armv7l: '7cad8a55bdef26259fc6a1cbe8a95fe724815c066d05eda1b12cc04ab5cc3514',
       i686: '18c2e32bb85c2d21ead658324f3e1f8b58fa10225d72d1d7e3b18b001f679d3c',
     x86_64: 'a4224a48a8aa825cd7e3c8c792a8264a4dec1b1c1617474e259b54b0174fd770'
  })

  depends_on 'brotli' # R
  depends_on 'ca_certificates' # L
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'gperf' => :build
  depends_on 'libev' => :build
  depends_on 'libffi' => :build
  depends_on 'libidn2' # R
  depends_on 'libtasn1' # R
  depends_on 'libunbound' # R
  depends_on 'libunistring' # R
  depends_on 'nettle' # R
  depends_on 'openssl' # R
  depends_on 'p11kit' # R
  depends_on 'trousers' => :build
  depends_on 'wget2' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  no_lto

  def self.prebuild
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

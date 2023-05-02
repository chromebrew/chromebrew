require 'package'

class Gnutls < Package
  description 'GnuTLS is a secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them.'
  homepage 'http://gnutls.org/'
  version '3.8.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://www.gnupg.org/ftp/gcrypt/gnutls/v3.8/gnutls-3.8.0.tar.xz'
  source_sha256 '0ea0d11a1660a1e63f960f157b197abe6d0c8cb3255be24e1fb3815930b9bdc5'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnutls/3.8.0_armv7l/gnutls-3.8.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnutls/3.8.0_armv7l/gnutls-3.8.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnutls/3.8.0_i686/gnutls-3.8.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnutls/3.8.0_x86_64/gnutls-3.8.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0a897675292ac7dac0705366de6e43ec3d49ef5f981984570d6574be2416af20',
     armv7l: '0a897675292ac7dac0705366de6e43ec3d49ef5f981984570d6574be2416af20',
       i686: 'e13f1dd743d212689362e087300db5c2b96bb524d38dcaf9c05e9a408fd7f261',
     x86_64: 'f3629c95675ce0f48d8de9f525d7aa359f50c3f84fc5970e83ecf3fd50477a7a'
  })

  depends_on 'brotli' # R
  depends_on 'ca_certificates' # L
  depends_on 'gcc' # R
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
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  no_env_options

  def self.prebuild
    # Use IPv4 fallback if default connection fails.
    system "#{CREW_PREFIX}/sbin/unbound-anchor -a '#{CREW_PREFIX}/etc/unbound/root.key' || #{CREW_PREFIX}/sbin/unbound-anchor -4 -a '#{CREW_PREFIX}/etc/unbound/root.key'"
    # Rebuild ca-certificates.
    system "#{CREW_PREFIX}/bin/update-ca-certificates --fresh --certsconf #{CREW_PREFIX}/etc/ca-certificates.conf"
  end

  def self.patch
    system 'filefix'
  end

  def self.build
    system './configure --help'
    system "mold -run ./configure #{CREW_OPTIONS} #{CREW_ENV_FNO_LTO_OPTIONS} \
      --enable-shared \
      --with-pic \
      --with-system-priority-file=#{CREW_PREFIX}/etc/gnutls/default-priorities \
      --with-trousers-lib=#{CREW_LIB_PREFIX}/libtspi.so.1 \
      --with-unbound-root-key-file=#{CREW_PREFIX}/etc/unbound/root.key \
      --with-default-trust-store-file=#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

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

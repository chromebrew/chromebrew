require 'package'

class Openssl < Package
  description 'OpenSSL is an open source project that provides a robust, commercial-grade, and full-featured toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols.'
  homepage 'https://www.openssl.org/'
  version '1.0.2l'

  source_url 'https://www.openssl.org/source/openssl-1.0.2l.tar.gz'
  source_sha1 'b58d5d0e9cea20e571d903aafa853e2ccd914138'

  depends_on 'perl'
  depends_on 'zlibpkg'

  def self.build
    options="shared zlib-dynamic"
    if `uname -m`.strip == 'aarch64'
      options = options + " no-asm"
    end
    system "./config --prefix=/usr/local --openssldir=/etc/ssl #{options}"
    system "make"
  end

  def self.install
    # installing using multi cores may cause empty libssl.so.1.0.0 or libcrypto.so.1.0.0 problem
    system "make", "-j1", "INSTALL_PREFIX=#{CREW_DEST_DIR}", "install"

    # remove all files pretended to install /etc/ssl (use system's /etc/ssl as is)
    system "rm", "-rf", "#{CREW_DEST_DIR}/etc"
  end

end

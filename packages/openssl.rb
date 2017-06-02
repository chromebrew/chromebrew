require 'package'

class Openssl < Package
  description 'OpenSSL is an open source project that provides a robust, commercial-grade, and full-featured toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols.'
  homepage 'https://www.openssl.org/'
  version '1.0.2k'

  source_url 'ftp://openssl.org/source/openssl-1.0.2k.tar.gz'
  source_sha1 '5f26a624479c51847ebd2f22bb9f84b3b44dcb44'
  binary_url ({
    armv7l: 'https://github.com/jam7/chromebrew/releases/download/binaries/openssl-1.0.2k-chromeos-armv7l.tar.xz',
    i686:   'https://github.com/jam7/chromebrew/releases/download/binaries/openssl-1.0.2k-chromeos-i686.tar.xz',
    x86_64: 'https://github.com/jam7/chromebrew/releases/download/binaries/openssl-1.0.2k-chromeos-x86_64.tar.xz',
  })
  binary_sha1 ({
    armv7l: '3993fab089b11f215ae554f2dec27c7bb5c28a09',
    i686:   'ea4fbca401f62f75ff5ad758e52f54d595dd949b',
    x86_64: 'c32d211c0033380144527aaf00c6e04dd3dbc20a',
  })

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
    system "make", "INSTALL_PREFIX=#{CREW_DEST_DIR}", "install"

    # remove all files pretended to install /etc/ssl (use system's /etc/ssl as is)
    system "rm", "-rf", "#{CREW_DEST_DIR}/etc"
  end
end

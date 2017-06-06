require 'package'

class Openssl < Package
  description 'OpenSSL is an open source project that provides a robust, commercial-grade, and full-featured toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols.'
  homepage 'https://www.openssl.org/'
  version '1.0.2l'

  source_url 'https://github.com/openssl/openssl/archive/OpenSSL_1_0_2l.tar.gz'
  source_sha1 '5bea0957b371627e8ebbee5bef221519e94d547c'
  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/binaries/openssl-1.0.2l-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chromebrew/releases/download/binaries/openssl-1.0.2l-chromeos-armv7l.tar.xz',
  })
  binary_sha1 ({
    aarch64: '4c9eb37df898e9495a8f53e3aa7f6058063fa8ce',
    armv7l:  '4c9eb37df898e9495a8f53e3aa7f6058063fa8ce',
  })

  depends_on 'perl' => :build
  depends_on 'zlibpkg' => :build

  def self.build
    options="shared zlib-dynamic"
    if `uname -m`.strip == 'aarch64'
      options = options + " no-asm"
    end
    system "./config --prefix=/usr/local --openssldir=/etc/ssl #{options}"
    system "make"
    system "find . -name '*.so' -print | xargs strip -S"
    system "find . -name '*.so.*' -print | xargs strip -S"
  end

  def self.install
    system "make", "INSTALL_PREFIX=#{CREW_DEST_DIR}", "install"
    system "strip", "#{CREW_DEST_DIR}/usr/local/bin/openssl"
    system "find #{CREW_DEST_DIR}/usr/local -name 'lib*.a' -print | xargs rm"

    # move man to /usr/local/man
    system "mv", "#{CREW_DEST_DIR}/etc/ssl/man", "#{CREW_DEST_DIR}/usr/local/man"

    # remove all files pretended to install /etc/ssl (use system's /etc/ssl as is)
    system "rm", "-rf", "#{CREW_DEST_DIR}/etc"
  end

  def self.check
    system "make", "test"
  end
end

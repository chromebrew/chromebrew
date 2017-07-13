require 'package'

class Openssl < Package
  description 'OpenSSL is an open source project that provides a robust, commercial-grade, and full-featured toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols.'
  homepage 'https://www.openssl.org/'
  version '1.0.2l'

  source_url 'https://github.com/openssl/openssl/archive/OpenSSL_1_0_2l.tar.gz'
  source_sha256 'a3d3a7c03c90ba370405b2d12791598addfcafb1a77ef483c02a317a56c08485'
  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/binaries/openssl-1.0.2l-chromeos-armv7l.tar.xz',
    armv7l:  'https://github.com/jam7/chromebrew/releases/download/binaries/openssl-1.0.2l-chromeos-armv7l.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4af16174aa6a9f565a5895fedea89daf0c8fb66b8f26b0c8416f5456aa440ea5',
    armv7l:  '4af16174aa6a9f565a5895fedea89daf0c8fb66b8f26b0c8416f5456aa440ea5',
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
  end

  def self.install
    system "make", "INSTALL_PREFIX=#{CREW_DEST_DIR}", "install"
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

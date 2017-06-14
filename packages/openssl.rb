require 'package'

class Openssl < Package
  description 'OpenSSL is an open source project that provides a robust, commercial-grade, and full-featured toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols.'
  homepage 'https://www.openssl.org/'
  version '1.0.2l'
  source_url 'https://github.com/openssl/openssl/archive/OpenSSL_1_0_2l.tar.gz'
  source_sha256 'a3d3a7c03c90ba370405b2d12791598addfcafb1a77ef483c02a317a56c08485'

  depends_on 'perl' => :build
  depends_on 'zlibpkg' => :build

  def self.build
    options="shared zlib-dynamic"
    case `uname -m`.strip
    when "aarch64"
      # Specify armv7 since aarch64 uses armv7 as its user land.
      system "./Configure --prefix=/usr/local --openssldir=/etc/ssl #{options} linux-armv4 -march=armv7-a"
    else
      system "./config --prefix=/usr/local --openssldir=/etc/ssl #{options}"
    end
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

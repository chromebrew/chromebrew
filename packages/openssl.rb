require 'package'

class Openssl < Package
  description 'OpenSSL is an open source project that provides a robust, commercial-grade, and full-featured toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols.'
  homepage 'https://www.openssl.org/'
  version '1.0.2l-1'
  source_url 'https://github.com/openssl/openssl/archive/OpenSSL_1_0_2l.tar.gz'
  source_sha256 'a3d3a7c03c90ba370405b2d12791598addfcafb1a77ef483c02a317a56c08485'

  depends_on 'perl' => :build
  depends_on 'bc' => :build             # required for `make test`
  depends_on 'diffutils' => :build      # required for `make test`
  depends_on 'zlibpkg' => :build

  def self.build
    options="shared zlib-dynamic"

    # Change default optimization level for armv7l from -O3 to -O2 because
    # gcc-4.9.4 -O3 for armv7l cause `evp_test` problem like below.
    #
    #   Testing cipher CAMELLIA-256-OFB(decrypt)
    #   Key
    #   0000 60 3d eb 10 15 ca 71 be 2b 73 ae f0 85 7Decrypt failed
    #   d 77 81
    #   0010 1f 35 2c 07 3b 61 08 d7 2d 98 10 a3 09 14 df f4
    #
    system "sed -e '/linux-armv4/s/-O3/-O2/' -i Configure"

    # Specify armv7 for aarch64 since Chrome OS aarch64 uses armv7 binaries as its userland.
    case `uname -m`.strip
    when "aarch64"
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

    # remove all files under /etc/ssl (use system's /etc/ssl as is)
    system "rm", "-rf", "#{CREW_DEST_DIR}/etc"
  end

  def self.check
    system "make", "test"
  end
end

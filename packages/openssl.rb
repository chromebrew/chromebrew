require 'package'

class Openssl < Package
  description 'OpenSSL is an open source project that provides a robust, commercial-grade, and full-featured toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols.'
  homepage 'https://www.openssl.org/'
  version '1.0.2p-1'
  source_url 'https://github.com/openssl/openssl/archive/OpenSSL_1_0_2p.tar.gz'
  source_sha256 '95ca65a25bdd41e127e5f4054539e8532a46be602b43b44af7c7100172e7cd50'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openssl-1.0.2p-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openssl-1.0.2p-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/openssl-1.0.2p-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openssl-1.0.2p-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9d2a1bdeac0d26ec7a22a91e017064edf1799f1783ebb7bce89e92e95b68f043',
     armv7l: '9d2a1bdeac0d26ec7a22a91e017064edf1799f1783ebb7bce89e92e95b68f043',
       i686: '0329163f9f9c78433d8b3d22d5a94eccc067ff557810c0fc85d4a8090cacb494',
     x86_64: 'b61308c6d0cddb3a6e0713e9d47b95382b1c5f0f9495766cec1afa6a07ccf56c',
  })

  depends_on 'bc' => :build             # required for `make test`

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
    case ARCH
    when 'aarch64'
      system "./Configure --prefix=#{CREW_PREFIX} --openssldir=/etc/ssl #{options} linux-armv4 -march=armv7-a"
    when 'x86_64'
      system "./config --prefix=#{CREW_PREFIX} --libdir=lib64 --openssldir=/etc/ssl #{options}"
    else
      system "./config --prefix=#{CREW_PREFIX} --openssldir=/etc/ssl #{options}"
    end
    system 'make'
  end

  def self.install
    system "make", "INSTALL_PREFIX=#{CREW_DEST_DIR}", "install"
    system "find #{CREW_DEST_PREFIX} -name 'lib*.a' -print | xargs rm"

    # move man to #{CREW_PREFIX}/share/man
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/share")
    system "mv", "#{CREW_DEST_DIR}/etc/ssl/man", "#{CREW_DEST_PREFIX}/share/man"

    # remove all files under /etc/ssl (use system's /etc/ssl as is)
    system "rm", "-rf", "#{CREW_DEST_DIR}/etc"

    # compress man pages
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man1"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man3"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man5"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man7"
  end

  def self.check
    system "make", "test"
  end
end

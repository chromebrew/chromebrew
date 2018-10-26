require 'package'

class Openssl < Package
  description 'OpenSSL is an open source project that provides a robust, commercial-grade, and full-featured toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols.'
  homepage 'https://www.openssl.org/'
  version '1.0.2o'
  source_url 'https://github.com/openssl/openssl/archive/OpenSSL_1_0_2o.tar.gz'
  source_sha256 'fd8bff81636c262ff82cb22286957d73213f899c1a80a3ec712c7ae80761ea9b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openssl-1.0.2o-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openssl-1.0.2o-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/openssl-1.0.2o-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openssl-1.0.2o-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b7500bdbfd231f726182b415bbd3b27194e617df455f6f42bdd0e0822cf39a60',
     armv7l: 'b7500bdbfd231f726182b415bbd3b27194e617df455f6f42bdd0e0822cf39a60',
       i686: 'e6633187ec8ba10f13c4b4e2af0643f78409bcd84c596744289d47d9afdef664',
     x86_64: '45caf4d45bc65e494f7b77d1d454f0aff516a2f76656e00efa335cf38bcf7055',
  })

  depends_on 'compressdoc' => :build
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

    # move man to #{CREW_PREFIX}/man
    system "mv", "#{CREW_DEST_DIR}/etc/ssl/man", "#{CREW_DEST_PREFIX}/man"

    # remove all files under /etc/ssl (use system's /etc/ssl as is)
    system "rm", "-rf", "#{CREW_DEST_DIR}/etc"

    # compress man pages
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/man/man1"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/man/man3"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/man/man5"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/man/man7"
  end

  def self.check
    system "make", "test"
  end
end

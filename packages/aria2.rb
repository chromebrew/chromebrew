require 'package'

class Aria2 < Package
  description 'aria2 is a lightweight multi-protocol & multi-source, cross platform download utility operated in command-line. It supports HTTP/HTTPS, FTP, SFTP, BitTorrent and Metalink.'
  homepage 'https://aria2.github.io/'
  version '1.33.1'
  source_url 'https://github.com/aria2/aria2/releases/download/release-1.33.1/aria2-1.33.1.tar.xz'
  source_sha256 '2539e4844f55a1f1f5c46ad42744335266053a69162e964d9a2d80a362c75e1b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aria2-1.33.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aria2-1.33.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aria2-1.33.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aria2-1.33.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'afa65990c71c2db8c8af57e2bf52345db576929995f310335224249f642f749d',
     armv7l: 'afa65990c71c2db8c8af57e2bf52345db576929995f310335224249f642f749d',
       i686: 'aec5932f39758c78c098d25d07d115a2f2ad655083651c554263be538fffd29a',
     x86_64: '8457b44396e6ef4f76c3e386389ba742a08280bdea9a9376da1795ef07f28c2e',
  })

  depends_on 'c_ares'
  depends_on 'libgcrypt'
  depends_on 'libssh2'
  depends_on 'libxml2'
  depends_on 'sqlite'
  depends_on 'zlibpkg'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--without-libnettle',
      '--with-libgcrypt',
      '--disable-dependency-tracking'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

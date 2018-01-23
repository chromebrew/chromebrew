require 'package'

class Aria2 < Package
  description 'aria2 is a lightweight multi-protocol & multi-source, cross platform download utility operated in command-line. It supports HTTP/HTTPS, FTP, SFTP, BitTorrent and Metalink.'
  homepage 'https://aria2.github.io/'
  version '1.33.1-1'
  source_url 'https://github.com/aria2/aria2/releases/download/release-1.33.1/aria2-1.33.1.tar.xz'
  source_sha256 '2539e4844f55a1f1f5c46ad42744335266053a69162e964d9a2d80a362c75e1b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aria2-1.33.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aria2-1.33.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aria2-1.33.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aria2-1.33.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '25987f8b48bb8063ee39ae3a260aec1db1917974c6622dd10628cd7ca919a803',
     armv7l: '25987f8b48bb8063ee39ae3a260aec1db1917974c6622dd10628cd7ca919a803',
       i686: 'a1693909b4ae5ddd9f7d0c56b118b49cb4ab85f60965b2c67a16bee055eee7de',
     x86_64: '94053db3425eb109f7831f9db293c439d4c0b0e17e70f40a3a3a5514a48b2b9a',
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

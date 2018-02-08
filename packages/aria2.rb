require 'package'

class Aria2 < Package
  description 'aria2 is a lightweight multi-protocol & multi-source, cross platform download utility operated in command-line. It supports HTTP/HTTPS, FTP, SFTP, BitTorrent and Metalink.'
  homepage 'https://aria2.github.io/'
  version '1.33.1-2'
  source_url 'https://github.com/aria2/aria2/releases/download/release-1.33.1/aria2-1.33.1.tar.xz'
  source_sha256 '2539e4844f55a1f1f5c46ad42744335266053a69162e964d9a2d80a362c75e1b'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'c_ares'
  depends_on 'libgcrypt'
  depends_on 'libssh2'
  depends_on 'libxml2'
  depends_on 'openssl'
  depends_on 'sqlite'
  depends_on 'zlibpkg'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--without-libnettle',
      '--with-libgcrypt',
      '--with-openssl',
      '--enable-ssl',
      '--disable-dependency-tracking'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

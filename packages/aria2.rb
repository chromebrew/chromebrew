require 'package'

class Aria2 < Package
  description 'aria2 is a lightweight multi-protocol & multi-source, cross platform download utility operated in command-line. It supports HTTP/HTTPS, FTP, SFTP, BitTorrent and Metalink.'
  homepage 'https://aria2.github.io/'
  version '1.34.0'
  source_url 'https://github.com/aria2/aria2/archive/release-1.34.0.tar.gz'
  source_sha256 'bc68bf9a9f192280846e07d25b801c111ea47b9a954cd4deb6f455dbf5191996'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'c_ares'
  depends_on 'libgcrypt'
  depends_on 'sqlite'
  depends_on 'cppunit'

  def self.build
    system "autoreconf -i"
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--with-libgcrypt'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

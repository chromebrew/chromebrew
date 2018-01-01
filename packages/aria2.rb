require 'package'

class Aria2 < Package
  description 'aria2 is a lightweight multi-protocol & multi-source, cross platform download utility operated in command-line. It supports HTTP/HTTPS, FTP, SFTP, BitTorrent and Metalink.'
  homepage 'https://aria2.github.io/'
  version '1.33.1'
  source_url 'https://github.com/aria2/aria2/releases/download/release-1.33.1/aria2-1.33.1.tar.bz2'
  source_sha256 '32e8dc76da0c630da18d6a656afb117fef8f2f71d6f38e326a6e09fa113e2109'

  binary_url ({
  })
  binary_sha256 ({
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

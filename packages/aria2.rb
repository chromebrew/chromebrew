require 'package'

class Aria2 < Package
  description 'aria2 is a lightweight multi-protocol & multi-source, cross platform download utility operated in command-line. It supports HTTP/HTTPS, FTP, SFTP, BitTorrent and Metalink.'
  homepage 'https://aria2.github.io/'
  version '1.32.0'
  source_url 'https://github.com/aria2/aria2/releases/download/release-1.32.0/aria2-1.32.0.tar.xz'
  source_sha1 '91afc96d5ac8b5fb96ff221fba1fe6109b6f8b17'

  depends_on 'c_ares'
  depends_on 'libgcrypt'
  depends_on 'libsqlite3'
  depends_on 'libssh2'
  depends_on 'libxml2'
  depends_on 'zlibpkg'

  def self.build
    system './configure \
           --without-libnettle \
           --with-libgcrypt'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

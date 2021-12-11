require 'package'

class Aria2 < Package
  description 'aria2 is a lightweight multi-protocol & multi-source, cross platform download utility operated in command-line. It supports HTTP/HTTPS, FTP, SFTP, BitTorrent and Metalink.'
  homepage 'https://aria2.github.io/'
  @_ver = '1.36.0'
  version @_ver
  license 'GPL-2+-with-openssl-exception'
  compatibility 'all'
  source_url 'https://github.com/aria2/aria2.git'
  git_hashtag 'release-' + @_ver

  depends_on 'cppunit' => :build
  depends_on 'libgcrypt'
  depends_on 'libssh2'

  def self.build
    system 'autoreconf -fiv'
    system 'filefix'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
      --with-libnettle \
      --with-libgcrypt \
      --with-libssh2"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

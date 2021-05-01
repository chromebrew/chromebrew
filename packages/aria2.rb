require 'package'

class Aria2 < Package
  description 'aria2 is a lightweight multi-protocol & multi-source, cross platform download utility operated in command-line. It supports HTTP/HTTPS, FTP, SFTP, BitTorrent and Metalink.'
  homepage 'https://aria2.github.io/'
  @_ver = '1.35.0'
  version "#{@_ver}-3"
  license 'GPL-2+-with-openssl-exception'
  compatibility 'all'
  source_url "https://github.com/aria2/aria2/releases/download/release-#{@_ver}/aria2-#{@_ver}.tar.xz"
  source_sha256 '1e2b7fd08d6af228856e51c07173cfcf987528f1ac97e04c5af4a47642617dfd'

  depends_on 'libgcrypt'

  def self.build
    system "env #{CREW_ENV_OPTIONS}
     ./configure #{CREW_OPTIONS} \
      --without-libnettle \
      --with-libgcrypt \
      --disable-dependency-tracking \
      --without-libssh2"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

require 'package'

class Lftp < Package
  description 'LFTP is a sophisticated file transfer program for ftp/http/sftp/fish/torrent'
  homepage 'https://lftp.yar.ru'
  version '4.9.2'
  compatibility 'all'
  source_url 'https://lftp.yar.ru/ftp/lftp-4.9.2.tar.xz'
  source_sha256 'c517c4f4f9c39bd415d7313088a2b1e313b2d386867fe40b7692b83a20f0670d'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-nls --disable-dependency-tracking --with-linux-crypto"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

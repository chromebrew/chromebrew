require 'package'

class Lftp < Package
  description 'LFTP is a sophisticated file transfer program for ftp/http/sftp/fish/torrent'
  homepage 'https://lftp.yar.ru'
  version '4.9.1'
  compatibility 'all'
  source_url 'https://lftp.yar.ru/ftp/lftp-4.9.1.tar.xz'
  source_sha256 '5969fcaefd102955dd882f3bcd8962198bc537224749ed92f206f415207a024b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lftp-4.9.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lftp-4.9.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lftp-4.9.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lftp-4.9.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a803ec42009f43031b2d77d8ffe88933877d5d921fcb4bb093dd0e366ca3cfb1',
     armv7l: 'a803ec42009f43031b2d77d8ffe88933877d5d921fcb4bb093dd0e366ca3cfb1',
       i686: '2752fe7e4035e1847979379fcb1723a48bc9f06d6a37d3eda92c67fbe803ebdd',
     x86_64: '6001988f90424bb072329bf8ff8f84410c17e65dbd06a90d43f27f323453b731',
  })

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-nls --with-linux-crypto"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

require 'package'

class Lftp < Package
  description 'LFTP is a sophisticated file transfer program for ftp/http/sftp/fish/torrent'
  homepage 'https://lftp.yar.ru'
  version '4.9.1'
  source_url 'https://lftp.yar.ru/ftp/lftp-4.9.1.tar.xz'
  source_sha256 '5969fcaefd102955dd882f3bcd8962198bc537224749ed92f206f415207a024b'

  binary_url ({
  })
  binary_sha256 ({
  })


  def self.build
    system "./configure \
      --prefix=#{CREW_PREFIX} \
      --libdir=#{CREW_LIB_PREFIX} \
      --disable-nls \
      --with-linux-crypto"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

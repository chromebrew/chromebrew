require 'package'

class Lftp < Package
  description 'LFTP is a sophisticated file transfer program for ftp/http/sftp/fish/torrent'
  homepage 'https://lftp.yar.ru'
  version '4.9.2'
  compatibility 'all'
  source_url 'https://lftp.yar.ru/ftp/lftp-4.9.2.tar.xz'
  source_sha256 'c517c4f4f9c39bd415d7313088a2b1e313b2d386867fe40b7692b83a20f0670d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lftp-4.9.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lftp-4.9.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lftp-4.9.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lftp-4.9.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '370398386c9df785c8f13dce8f1d25313bfb5a5f0a472e4abd14664abcae51aa',
     armv7l: '370398386c9df785c8f13dce8f1d25313bfb5a5f0a472e4abd14664abcae51aa',
       i686: '07e9ced116f2c5cec2f1a05b866493ba8df967cc7af2d7703a50224e3242e85a',
     x86_64: 'd8df0155b54627beb280cc208d40c6f702a1aa970e9863ac17c154d9f478d9db',
  })

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-nls --disable-dependency-tracking --with-linux-crypto"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

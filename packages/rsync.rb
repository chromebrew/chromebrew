require 'package'

class Rsync < Package
  description 'rsync is an open source utility that provides fast incremental file transfer.'
  homepage 'https://rsync.samba.org/'
  version '3.1.3'
  compatibility 'all'
  source_url 'http://rsync.samba.org/ftp/rsync/src/rsync-3.1.3.tar.gz'
  source_sha256 '55cc554efec5fdaad70de921cd5a5eeb6c29a95524c715f3bbf849235b0800c0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/rsync-3.1.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/rsync-3.1.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/rsync-3.1.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/rsync-3.1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '12356628fc5fd0f85f88e5e55e1ba45e484cbd59255bcbcb897e7efd57d4d02e',
     armv7l: '12356628fc5fd0f85f88e5e55e1ba45e484cbd59255bcbcb897e7efd57d4d02e',
       i686: '8bfe64b4be932754bc43437e9fcbbc85a186520845b9c38a953c56708070d9f1',
     x86_64: '7d443ccd165fa47273dcad879c598ee3c024edc57c6ce2d56206aa7d1724c287',
  })

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

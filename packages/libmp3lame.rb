require 'package'

class Libmp3lame < Package
  description 'LAME is a high quality MPEG Audio Layer III (MP3) encoder licensed under the LGPL.'
  homepage 'http://lame.sourceforge.net/'
  version '3.99.5'
  source_url 'https://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz'
  source_sha256 '24346b4158e4af3bd9f2e194bb23eb473c75fb7377011523353196b19b9a23ff'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libmp3lame-3.99.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libmp3lame-3.99.5-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libmp3lame-3.99.5-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libmp3lame-3.99.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0963e15567dc5d7725866879bd656fa3f73fc0fbdc1d2cab03268f5bb3d7b6ca',
     armv7l: '0963e15567dc5d7725866879bd656fa3f73fc0fbdc1d2cab03268f5bb3d7b6ca',
       i686: '02c3ca58a7cf2ed099be949ac2c83cc1c5fe090526fe028170bcdf1201eddd2f',
     x86_64: '18f2a6455412ffba174144a9b160e8fbab34af4171b6a88338e542112333054b',
  })

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

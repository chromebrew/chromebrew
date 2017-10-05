require 'package'

class Htop < Package
  description 'htop is an interactive process viewer for Unix systems.'
  homepage 'https://hisham.hm/htop/'
  version '2.0.2-1'
  source_url 'http://hisham.hm/htop/releases/2.0.2/htop-2.0.2.tar.gz'
  source_sha256 '179be9dccb80cee0c5e1a1f58c8f72ce7b2328ede30fb71dcdf336539be2f487'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/htop-2.0.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/htop-2.0.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/htop-2.0.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/htop-2.0.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '82c99e18dc24b915467acdc4b6e06b8e673d76667ca830528411b09df5fc7583',
     armv7l: '82c99e18dc24b915467acdc4b6e06b8e673d76667ca830528411b09df5fc7583',
       i686: 'b8b34913c160374c5cfb97646c9f87628d19aa9fbd7bf8565ecb96edadaea0a0',
     x86_64: '5e1faafcb9559adf098f2a4e03d282202d981522ad4a84d515d2006363fd840c',
  })

  depends_on 'buildessential'  => :build
  depends_on 'ncurses'

  def self.build
    system "./configure --disable-unicode"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

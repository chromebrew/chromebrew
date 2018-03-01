require 'package'

class Htop < Package
  description 'htop is an interactive process viewer for Unix systems.'
  homepage 'https://hisham.hm/htop/'
  version '2.0.2-1'
  source_url 'http://hisham.hm/htop/releases/2.0.2/htop-2.0.2.tar.gz'
  source_sha256 '179be9dccb80cee0c5e1a1f58c8f72ce7b2328ede30fb71dcdf336539be2f487'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/htop-2.0.2-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/htop-2.0.2-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/htop-2.0.2-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/htop-2.0.2-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8d4d0463452df4e8845023fc1850b702264a46f6663585065f1f7d8622d1d9df',
     armv7l: '8d4d0463452df4e8845023fc1850b702264a46f6663585065f1f7d8622d1d9df',
       i686: '7abcbd50cbd5dfda4237fe8532c49d971b891d51a5216f3587e60ea5e74a35d0',
     x86_64: '632158634495f1e44312cab51f9fcbdc7d6bb49f66ea236beaedf7434311112b',
  })

  depends_on 'buildessential'  => :build
  depends_on 'ncurses'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --disable-unicode"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

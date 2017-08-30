require 'package'

class Graphicsmagick < Package
  description 'GraphicsMagick is the swiss army knife of image processing.'
  homepage 'http://www.graphicsmagick.org/'
  version '1.3.26'
  source_url 'https://downloads.sourceforge.net/project/graphicsmagick/graphicsmagick/1.3.26/GraphicsMagick-1.3.26.tar.xz'
  source_sha256 'fba015f3d5e5d5f17e57db663f1aa9d338e7b62f1d415b85d13ee366927e5f88'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/graphicsmagick-1.3.26-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/graphicsmagick-1.3.26-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/graphicsmagick-1.3.26-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/graphicsmagick-1.3.26-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0ea513e19f384e321dd2081337d6097decadbc45f4def74f063229ff9f355347',
     armv7l: '0ea513e19f384e321dd2081337d6097decadbc45f4def74f063229ff9f355347',
       i686: '1959c3cbf69b90399b719ddb968b3e92b86ceedcc042149307b3dddcafad8390',
     x86_64: 'e8de3207d98210454874c9c4f8b92a50cba0e3c08b82fe54307031e8a8e32c00',
  })

  depends_on 'buildessential'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

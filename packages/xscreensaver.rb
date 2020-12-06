require 'package'

class Xscreensaver < Package
  description 'XScreenSaver is the standard screen saver collection shipped on most Linux and Unix systems running the X11 Window System.'
  homepage 'https://www.jwz.org/xscreensaver/download.html'
  version '5.44'
  compatibility 'all'
  source_url 'https://www.jwz.org/xscreensaver/xscreensaver-5.44.tar.gz'
  source_sha256 '73d8089cfc7d7363b5dac99b5b01dffb3429d0a855e6af16ce9a4b7777017b95'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xscreensaver-5.44-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xscreensaver-5.44-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xscreensaver-5.44-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xscreensaver-5.44-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6e6fe321404454f174492ed9b116ed339b7b3053c86d6af7b463d266b4558feb',
     armv7l: '6e6fe321404454f174492ed9b116ed339b7b3053c86d6af7b463d266b4558feb',
       i686: '601c1c6c14e128d6ec5bd69949cd7f25e50c7cd29b57cc2faf075ae0c36e0f60',
     x86_64: '9f318d5f089884acfcef0ccfd0147535a44b38957f94338ff2f97e1cec27f3c0',
  })

  depends_on 'glfw'
  depends_on 'freeglut'
  depends_on 'sommelier'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} PREFIX=#{CREW_PREFIX} install"
  end
end

require 'package'

class Emacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'http://www.gnu.org/software/emacs/'
  version '26.3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/emacs/emacs-26.3.tar.xz'
  source_sha256 '4d90e6751ad8967822c6e092db07466b9d383ef1653feb2f95c93e7de66d3485'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-26.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-26.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-26.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-26.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cb3fbd500feee768ab1925d9a62c587563a5dbb362dea8fec72017e17990454b',
     armv7l: 'cb3fbd500feee768ab1925d9a62c587563a5dbb362dea8fec72017e17990454b',
       i686: 'ef10c17c31286f47a0ae03204a406421501f452184b37fc6411d4c6cfa88381b',
     x86_64: 'd32ea23bb1c6ecc1588f2665da8c5f47367cf78b4dc9cefabed36a9386c748a2',
  })

  depends_on 'lcms'
  depends_on 'libjpeg'

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --localstatedir=#{CREW_PREFIX}/share \
            --with-x=no \
            --without-makeinfo \
            --without-selinux"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

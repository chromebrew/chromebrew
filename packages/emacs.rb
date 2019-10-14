require 'package'

class Emacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'http://www.gnu.org/software/emacs/'
  version '26.2'
  source_url 'https://ftpmirror.gnu.org/emacs/emacs-26.2.tar.xz'
  source_sha256 '151ce69dbe5b809d4492ffae4a4b153b2778459de6deb26f35691e1281a9c58e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-26.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-26.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-26.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-26.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e87f63d8952e1675ec40d34f836403fd9afe3990da059583f861f4bf31b57d0d',
     armv7l: 'e87f63d8952e1675ec40d34f836403fd9afe3990da059583f861f4bf31b57d0d',
       i686: '371b943a131d8f789b7d65dffd21fc0e2831bf60b3599e434db852c9bafe2e9d',
     x86_64: 'a32d38360b671f6bf54def9db590d3687896449a1a4f335a98b1c9fba22a1693',
  })

  depends_on 'lcms'
  depends_on 'libjpeg'
  depends_on 'libpng'

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
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

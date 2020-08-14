require 'package'

class Emacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'http://www.gnu.org/software/emacs/'
  version '27.1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/emacs/emacs-27.1.tar.xz'
  source_sha256 '4a4c128f915fc937d61edfc273c98106711b540c9be3cd5d2e2b9b5b2f172e41'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-27.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-27.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-27.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-27.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2a4c0e724b6d5d05ae99418cad0557dc6e72c04e66dbccc041971bd3d954f408',
     armv7l: '2a4c0e724b6d5d05ae99418cad0557dc6e72c04e66dbccc041971bd3d954f408',
       i686: 'e428b1bcf011ce6a81a057b7b757436385ad11c5e3b34d5508d2ed3411b27047',
     x86_64: 'ee87e75116c30bdfcab5c92dff5f7413c6b7bdc1fe813727dce16f21f2b0ec61',
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

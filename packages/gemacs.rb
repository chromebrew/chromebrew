require 'package'

class Gemacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'https://www.gnu.org/software/emacs/'
  version '27.1-1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/emacs/emacs-27.1.tar.xz'
  source_sha256 '4a4c128f915fc937d61edfc273c98106711b540c9be3cd5d2e2b9b5b2f172e41'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-27.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-27.1-1-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-27.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5d238f878cd80fa41dc83a3abc4a956466c08b336c2e01025a1bc2eb5532be72',
     armv7l: '5d238f878cd80fa41dc83a3abc4a956466c08b336c2e01025a1bc2eb5532be72',
     x86_64: '427c6f1c7143c449f7d2e53d82c82d191e87fed49d2e921916fc7aef2584ac0d',
  })

  depends_on 'giflib'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'imagemagick7'
  depends_on 'sommelier'

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --localstatedir=#{CREW_PREFIX}/share \
            --without-selinux \
            --with-modules \
            --with-imagemagick \
            --with-x=yes \
            --with-x-toolkit=gtk3 \
            --with-gif=yes \
            --with-jpeg=yes \
            --with-png=yes \
            --with-rsvg=yes"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "install -Dm755 src/emacs #{CREW_DEST_PREFIX}/bin/gemacs"
    system "install -Dm755 src/emacs-27.1.1 #{CREW_DEST_PREFIX}/bin/gemacs-27.1.1"
  end
end

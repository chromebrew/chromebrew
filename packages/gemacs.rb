require 'package'

class Gemacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'https://www.gnu.org/software/emacs/'
  version '27.1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/emacs/emacs-27.1.tar.xz'
  source_sha256 '4a4c128f915fc937d61edfc273c98106711b540c9be3cd5d2e2b9b5b2f172e41'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-27.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-27.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-27.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-27.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '303510f76a0b25adbf43299521ff13ca40dfb5442e907084b06865515eb56b6e',
     armv7l: '303510f76a0b25adbf43299521ff13ca40dfb5442e907084b06865515eb56b6e',
       i686: 'c5e322757cc41505365d52f48a1668c1fb44d28ded3ac75687c6f7e96bc38c8e',
     x86_64: 'e6ab6fb5a2aa094a2589a805e2539b0fc2a1dbddbb88d203e2c536dcf903aba8',
  })

  depends_on 'giflib'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'imagemagick6'
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

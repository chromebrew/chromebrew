require 'package'

class Emacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'http://www.gnu.org/software/emacs/'
  version '27.1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/emacs/emacs-27.1.tar.xz'
  source_sha256 '4a4c128f915fc937d61edfc273c98106711b540c9be3cd5d2e2b9b5b2f172e41'

  binary_url ({
  })
  binary_sha256 ({
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

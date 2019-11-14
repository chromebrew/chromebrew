require 'package'

class Emacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'http://www.gnu.org/software/emacs/'
  version '26.3-1'
  source_url 'https://ftpmirror.gnu.org/emacs/emacs-26.3.tar.xz'
  source_sha256 '4d90e6751ad8967822c6e092db07466b9d383ef1653feb2f95c93e7de66d3485'

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

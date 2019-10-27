require 'package'

class Gemacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'http://www.gnu.org/software/emacs/'
  version '26.3'
  source_url 'https://ftpmirror.gnu.org/emacs/emacs-26.3.tar.xz'
  source_sha256 '4d90e6751ad8967822c6e092db07466b9d383ef1653feb2f95c93e7de66d3485'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'emacs'
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
            --with-x=yes \
            --with-x-toolkit=gtk3 \
            --with-gif=yes \
	    --with-jpeg=yes \
	    --with-png=yes \
	    --with-rsvg=yes" 
    system 'make'
  end

  def self.install
    system "install -Dm755 src/emacs #{CREW_DEST_PREFIX}/bin/gemacs"
    system "install -Dm755 src/emacs-26.3.1 #{CREW_DEST_PREFIX}/bin/gemacs-26.3.1"
  end
end

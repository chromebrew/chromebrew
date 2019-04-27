require 'package'

class Gemacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'http://www.gnu.org/software/emacs/'
  version '26.2'
  source_url 'https://ftp.gnu.org/gnu/emacs/emacs-26.2.tar.xz'
  source_sha256 '151ce69dbe5b809d4492ffae4a4b153b2778459de6deb26f35691e1281a9c58e'

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
            --with-x=yes \
            --with-x-toolkit=gtk3 \
            --with-gif=yes \
	    --with-jpeg=yes \
	    --with-png=yes \
	    --with-rsvg=yes" 
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "rm -rf #{CREW_DEST_DIR}"
    system "install -Dm755 src/emacs #{CREW_DEST_PREFIX}/bin/gemacs"
    system "install -Dm755 src/emacs-26.2.1 #{CREW_DEST_PREFIX}/bin/gemacs-26.2.1"
  end
end

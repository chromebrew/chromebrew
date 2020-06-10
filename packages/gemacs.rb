require 'package'

class Gemacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'https://www.gnu.org/software/emacs/'
  version '26.3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/emacs/emacs-26.3.tar.xz'
  source_sha256 '4d90e6751ad8967822c6e092db07466b9d383ef1653feb2f95c93e7de66d3485'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-26.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-26.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-26.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-26.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '45bae4cffee76691bf89478032d4ac68faf331b263696b6236b3cdcaa9ae8eee',
     armv7l: '45bae4cffee76691bf89478032d4ac68faf331b263696b6236b3cdcaa9ae8eee',
       i686: '2980639d04f3d911773b3a97f0a99e604eb38f5155beabafb3d02cb033ce3a93',
     x86_64: '3e3becfa06271d8b9a13aacdbc0a9f3aeade8ddfa7991f1a24c4f6b8bdc30a89',
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

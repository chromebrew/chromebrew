require 'package'

class Gemacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'http://www.gnu.org/software/emacs/'
  version '26.2'
  source_url 'https://ftpmirror.gnu.org/emacs/emacs-26.2.tar.xz'
  source_sha256 '151ce69dbe5b809d4492ffae4a4b153b2778459de6deb26f35691e1281a9c58e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-26.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-26.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-26.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-26.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cf400dc1a499f64c25c5fd08cb954305f62bba1f65bfaddeea799205d59fe506',
     armv7l: 'cf400dc1a499f64c25c5fd08cb954305f62bba1f65bfaddeea799205d59fe506',
       i686: 'd0b38c6c09d92c73dd0c02aff134b364ef1a05ff2e530a04b83e53aa62fed95c',
     x86_64: '120a8438b8ab8fda338f38151a2846528ba41a06923e294ed43b2c090c86a113',
  })

  depends_on 'emacs'
  depends_on 'giflib'
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
    system "install -Dm755 src/emacs-26.2.1 #{CREW_DEST_PREFIX}/bin/gemacs-26.2.1"
  end
end

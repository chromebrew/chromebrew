require 'package'

class Gemacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'https://www.gnu.org/software/emacs/'
  @_ver = '27.1'
  version "#{@_ver}-2"
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/emacs/emacs-#{@_ver}.tar.xz"
  source_sha256 '4a4c128f915fc937d61edfc273c98106711b540c9be3cd5d2e2b9b5b2f172e41'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-27.1-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-27.1-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-27.1-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-27.1-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '270c65753da8ff73172aaecf8696eef4645204904d2345620ea54d24a880a814',
     armv7l: '270c65753da8ff73172aaecf8696eef4645204904d2345620ea54d24a880a814',
       i686: '2b94b8c5016dbf1e39cdaf4d78e8678a9414232bac93701e0ba2e10e7864b428',
     x86_64: '5055031715b416892f0da3c5d3faf0ff535e1ca74d57be96e8d2c0956de79794'
  })

  depends_on 'giflib'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'imagemagick7'
  depends_on 'sommelier'

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure \
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

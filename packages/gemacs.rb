require 'package'

class Gemacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'https://www.gnu.org/software/emacs/'
  @_ver = '28.0.50.1'
  version "#{@_ver}-fb5f"
  license 'GPL-3+, FDL-1.3+, BSD, HPND, MIT, W3C, unicode, PSF-2'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/emacs.git'
  git_branch 'feature/pgtk'
  git_hashtag 'fb5f3e694b0f6e2bccfc2124555c986fdc409cd0'

  depends_on 'alsa_lib'
  depends_on 'cairo'
  depends_on 'giflib'
  depends_on 'gpm'
  depends_on 'gtk3'
  depends_on 'harfbuzz'
  depends_on 'jansson'
  depends_on 'libjpeg'
  depends_on 'libotf'
  depends_on 'libpng'
  depends_on 'librsvg'
  depends_on 'libtiff'
  depends_on 'texinfo'
  depends_on 'webkit2gtk'

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system "env #{CREW_ENV_OPTIONS} \
      ./configure \
      --enable-link-time-optimization \
      --localstatedir=#{CREW_PREFIX}/share \
      --prefix=#{CREW_PREFIX} \
      --with-cairo \
      --with-gif=ifavailable \
      --with-jpeg=yes \
      --with-modules \
      --with-native-compilation \
      --without-gconf \
      --without-gsettings \
      --without-selinux \
      --without-x \
      --with-pgtk \
      --with-png=yes \
      --with-rsvg=yes \
      --with-sound=alsa \
      --with-tiff=ifavailable \
      --with-x-toolkit=gtk3 \
      --with-xwidgets"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "install -Dm755 src/emacs #{CREW_DEST_PREFIX}/bin/gemacs"
    system "install -Dm755 src/emacs-#{@_ver} #{CREW_DEST_PREFIX}/bin/gemacs-#{@_ver}"
  end
end

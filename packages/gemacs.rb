require 'package'

class Gemacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'https://www.gnu.org/software/emacs/'
  version '28.2-1'
  license 'GPL-3+, FDL-1.3+, BSD, HPND, MIT, W3C, unicode, PSF-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://ftpmirror.gnu.org/emacs/emacs-28.2.tar.xz'
  source_sha256 'ee21182233ef3232dc97b486af2d86e14042dbb65bbc535df562c3a858232488'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gemacs/28.2-1_armv7l/gemacs-28.2-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gemacs/28.2-1_armv7l/gemacs-28.2-1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gemacs/28.2-1_x86_64/gemacs-28.2-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f966730acbfa66004237d915ae05c0bf94a3d595521e6d78f2b9c02393e6d8ef',
     armv7l: 'f966730acbfa66004237d915ae05c0bf94a3d595521e6d78f2b9c02393e6d8ef',
     x86_64: 'c3ea71b0e801bde5daddcb6880b59b0a776fc70b207fc5783631c82ad6e4f5ae'
  })

  depends_on 'acl' # R
  depends_on 'alsa_lib' # R
  depends_on 'at_spi2_core' # R
  depends_on 'cairo'
  depends_on 'dbus' # R
  depends_on 'freetype' # R
  depends_on 'gcc' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'giflib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gmp' # R
  depends_on 'gnutls' # R
  depends_on 'gpm' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'jansson' # R
  depends_on 'lcms' # R
  depends_on 'libice' # R
  depends_on 'libjpeg' # R
  depends_on 'libotf' # R
  depends_on 'libpng' # R
  depends_on 'librsvg' # R
  depends_on 'libsm' # R
  depends_on 'libsoup2' # R
  depends_on 'libtiff' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxcomposite' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxinerama' # R
  depends_on 'libxml2' # R
  depends_on 'libxpm' # R
  depends_on 'libxrandr' # R
  depends_on 'libxrender' # R
  depends_on 'ncurses' # R
  depends_on 'pango' # R
  depends_on 'texinfo'
  depends_on 'webkit2gtk_4'
  depends_on 'zlibpkg' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure \
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
    FileUtils.install 'src/emacs', "#{CREW_DEST_PREFIX}/bin/gemacs", mode: 0o755
    FileUtils.install 'src/emacs', "#{CREW_DEST_PREFIX}/bin/gemacs-#{version}", mode: 0o755
  end
end

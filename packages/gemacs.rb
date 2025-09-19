require 'buildsystems/autotools'

class Gemacs < Autotools
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'https://www.gnu.org/software/emacs/'
  version '30.2'
  license 'GPL-3+, FDL-1.3+, BSD, HPND, MIT, W3C, unicode, PSF-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://ftpmirror.gnu.org/emacs/emacs-#{version}.tar.xz"
  source_sha256 'b3f36f18a6dd2715713370166257de2fae01f9d38cfe878ced9b1e6ded5befd9'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '85293f6a1e96f1b3aca3b613f3e139b335d9758491bb0364efed84c088cff0d4',
     armv7l: '85293f6a1e96f1b3aca3b613f3e139b335d9758491bb0364efed84c088cff0d4',
     x86_64: '12d16157477a3726a16c349e420e05f70b93bb6f5093faeee6c22f0331a883c9'
  })

  depends_on 'acl' # R
  depends_on 'alsa_lib' # R
  depends_on 'at_spi2_core' # R
  depends_on 'cairo'
  depends_on 'dbus' # R
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc_dev' # R
  depends_on 'gcc_lib' # R
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
  depends_on 'libjpeg_turbo' # R
  depends_on 'libotf' # R
  depends_on 'libpng' # R
  depends_on 'librsvg' # R
  depends_on 'libsm' # R
  depends_on 'libsoup2' # R
  depends_on 'libtiff' # R
  depends_on 'libwebp' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxcomposite' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxinerama' # R
  depends_on 'libxi' # R
  depends_on 'libxml2' # R
  depends_on 'libxpm' # R
  depends_on 'libxrandr' # R
  depends_on 'libxrender' # R
  depends_on 'ncurses' # R
  depends_on 'pango' # R
  depends_on 'sqlite' # R
  depends_on 'texinfo'
  depends_on 'webkit2gtk_4'
  depends_on 'xcb_util' # R
  depends_on 'zlib' # R

  autotools_configure_options "--enable-link-time-optimization \
      --localstatedir=#{CREW_PREFIX}/share \
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

  autotools_install_extras do
    FileUtils.install 'src/emacs', "#{CREW_DEST_PREFIX}/bin/gemacs", mode: 0o755
    FileUtils.install 'src/emacs', "#{CREW_DEST_PREFIX}/bin/gemacs-#{version}", mode: 0o755
  end
end

require 'package'

class Gemacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'https://www.gnu.org/software/emacs/'
  version '29.1'
  license 'GPL-3+, FDL-1.3+, BSD, HPND, MIT, W3C, unicode, PSF-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://ftp.gnu.org/gnu/emacs/emacs-29.1.tar.xz'
  source_sha256 'd2f881a5cc231e2f5a03e86f4584b0438f83edd7598a09d24a21bd8d003e2e01'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '85293f6a1e96f1b3aca3b613f3e139b335d9758491bb0364efed84c088cff0d4',
     armv7l: '85293f6a1e96f1b3aca3b613f3e139b335d9758491bb0364efed84c088cff0d4',
     x86_64: '12d16157477a3726a16c349e420e05f70b93bb6f5093faeee6c22f0331a883c9'
  })

  depends_on 'acl' => :executable
  depends_on 'alsa_lib' => :executable
  depends_on 'at_spi2_core' => :executable
  depends_on 'cairo'
  depends_on 'cairo' => :executable
  depends_on 'dbus' => :executable
  depends_on 'fontconfig' => :executable
  depends_on 'freetype' => :executable
  depends_on 'gcc_dev' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'gdk_pixbuf' => :executable
  depends_on 'giflib' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' # R
  depends_on 'glibc' => :executable
  depends_on 'gmp' => :executable
  depends_on 'gnutls' => :executable
  depends_on 'gpm' => :executable
  depends_on 'gtk3' => :executable
  depends_on 'harfbuzz' => :executable
  depends_on 'jansson' => :executable
  depends_on 'lcms' => :executable
  depends_on 'libice' => :executable
  depends_on 'libjpeg_turbo' => :executable
  depends_on 'libotf' => :executable
  depends_on 'libpng' => :executable
  depends_on 'librsvg' => :executable
  depends_on 'libsm' => :executable
  depends_on 'libsoup2' => :executable
  depends_on 'libtiff' => :executable
  depends_on 'libwebp' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxcb' => :executable
  depends_on 'libxcomposite' => :executable
  depends_on 'libxext' => :executable
  depends_on 'libxfixes' => :executable
  depends_on 'libxi' => :executable
  depends_on 'libxinerama' => :executable
  depends_on 'libxml2' # R
  depends_on 'libxpm' => :executable
  depends_on 'libxrandr' => :executable
  depends_on 'libxrender' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'pango' => :executable
  depends_on 'sqlite' => :executable
  depends_on 'texinfo'
  depends_on 'webkit2gtk_4'
  depends_on 'webkit2gtk_4' => :executable
  depends_on 'xcb_util' => :executable
  depends_on 'zlib' => :executable

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

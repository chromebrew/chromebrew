require 'package'

class Xterm < Package
  description 'The xterm program is a terminal emulator for the X Window System.'
  homepage 'https://invisible-island.net/xterm/'
  version '378c'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ThomasDickey/xterm-snapshots.git'
  git_hashtag "xterm-#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xterm/378c_armv7l/xterm-378c-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xterm/378c_armv7l/xterm-378c-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xterm/378c_i686/xterm-378c-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xterm/378c_x86_64/xterm-378c-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a8302b75325cda9acbf59929ecaf791281e2710b1c9e128354844145aa9c2d40',
     armv7l: 'a8302b75325cda9acbf59929ecaf791281e2710b1c9e128354844145aa9c2d40',
       i686: '235f5938788fbc494bac5bac66a15259795ddad186b081ace5a21092f995942c',
     x86_64: '88353d7c42d3a91c5d7f1440d78808c6625cbf5cb9a186ebe10a8a2caeda37af'
  })

  depends_on 'libxaw' => :build
  depends_on 'sommelier'
  depends_on 'freetype' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libice' # R
  depends_on 'libutempter' # R
  depends_on 'libx11' # R
  depends_on 'libxaw' # R
  depends_on 'libxext' # R
  depends_on 'libxft' # R
  depends_on 'libxinerama' # R
  depends_on 'libxmu' # R
  depends_on 'libxpm' # R
  depends_on 'libxt' # R
  depends_on 'luit' => :build
  depends_on 'ncurses' # R
  depends_on 'pcre' # R

  no_env_options

  def self.patch
    system "sed -i '/^LDFLAGS/ s/$/ -DUSE_TERMINFO=1 -ltinfo/' Makefile.in"
  end

  def self.build
    system "./configure #{CREW_OPTIONS} \
      --disable-imake \
      --enable-16bit-chars \
      --enable-256-color \
      --enable-88-color \
      --enable-ansi-color \
      --enable-broken-osc \
      --enable-broken-st \
      --enable-dabbrev \
      --enable-dec-locator \
      --enable-double-buffer \
      --enable-doublechars \
      --enable-exec-xterm \
      --enable-freetype \
      --enable-i18n \
      --enable-load-vt-fonts \
      --enable-logging \
      --enable-luit \
      --enable-mini-luit \
      --enable-narrowproto \
      --enable-readline-mouse \
      --enable-regis-graphics \
      --enable-sixel-graphics \
      --enable-tcap-query \
      --enable-toolbar \
      --enable-warnings \
      --enable-wide-chars \
      --with-app-defaults=#{CREW_PREFIX}/share/X11/app-defaults/ \
      --with-pcre \
      --with-pkg-config \
      --with-tty-group=tty \
      --with-utempter \
      --with-x \
      --with-xinerama \
      --with-xpm=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
    system "make install-ti DESTDIR=#{CREW_DEST_DIR}"
  end
end

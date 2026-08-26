require 'package'

class Xterm < Package
  description 'The xterm program is a terminal emulator for the X Window System.'
  homepage 'https://invisible-island.net/xterm/'
  version '411'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ThomasDickey/xterm-snapshots.git'
  git_hashtag "xterm-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6e0fada45b3f5c9deeee74dbcad76833f2f9d4b519eb9c86cd0895308e960d2b',
     armv7l: '6e0fada45b3f5c9deeee74dbcad76833f2f9d4b519eb9c86cd0895308e960d2b',
     x86_64: 'a343f5962926a0a48406bd5bd9e948d45827bc5141f468b439fcb0647aaf761f'
  })

  depends_on 'fontconfig' => :executable
  depends_on 'freetype' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'harfbuzz' => :executable
  depends_on 'libice' => :executable
  depends_on 'libutempter' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxaw' => :executable
  depends_on 'libxext' => :executable
  depends_on 'libxft' => :executable
  depends_on 'libxinerama' => :executable
  depends_on 'libxmu' => :executable
  depends_on 'libxpm' => :executable
  depends_on 'libxt' => :executable
  depends_on 'luit' => :build
  depends_on 'ncurses' => :executable
  depends_on 'pcre' => :executable
  depends_on 'sommelier' => :logical

  conflicts_ok # conflicts with terminfo defs in ncurses
  no_env_options

  def self.patch
    system "sed -i '/^LDFLAGS/ s/$/ -DUSE_TERMINFO=1 -ltinfo/' Makefile.in"
  end

  def self.build
    system "./configure #{CREW_CONFIGURE_OPTIONS} \
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

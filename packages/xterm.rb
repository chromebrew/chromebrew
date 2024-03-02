require 'package'

class Xterm < Package
  description 'The xterm program is a terminal emulator for the X Window System.'
  homepage 'https://invisible-island.net/xterm/'
  version '390'
  license 'MIT'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://github.com/ThomasDickey/xterm-snapshots.git'
  git_hashtag "xterm-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6248935abd526d98dedaf033475bf4ef967dec6f450cd4ffa0536f3a61ff31e1',
     armv7l: '6248935abd526d98dedaf033475bf4ef967dec6f450cd4ffa0536f3a61ff31e1',
     x86_64: '804f23057165662f203994db4614ca2595a1a2a403a1b35ba8909501fb209a6d'
  })

  depends_on 'libxaw' => :build
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
  depends_on 'sommelier'

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

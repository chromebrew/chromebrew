require 'package'

class Xterm < Package
  description 'The xterm program is a terminal emulator for the X Window System.'
  homepage 'https://invisible-island.net/xterm/'
  version '407'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ThomasDickey/xterm-snapshots.git'
  git_hashtag "xterm-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f5d2412ff0cc2c04b1f8e4586a1a0836592fca8186394528194f772437def082',
     armv7l: 'f5d2412ff0cc2c04b1f8e4586a1a0836592fca8186394528194f772437def082',
     x86_64: 'e45a39d55d55557d24dbc627e1471204d64aaacc9478a53b22b3a857b14a0d86'
  })

  depends_on 'fontconfig' # R
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
  depends_on 'sommelier' => :logical

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

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
    aarch64: 'e51a11c5222c7eef82730162b8a417c304fc4110c402806c40ee9c2801d5b065',
     armv7l: 'e51a11c5222c7eef82730162b8a417c304fc4110c402806c40ee9c2801d5b065',
     x86_64: '70ee2c01f0528f6ac62972a38bab18a8f8b1ab3e7b1f18cce48c0e4879c9a11d'
  })

  depends_on 'fontconfig' => :executable_only
  depends_on 'freetype' => :executable_only
  depends_on 'glibc' => :executable_only
  depends_on 'harfbuzz' => :executable_only
  depends_on 'libice' => :executable_only
  depends_on 'libutempter' => :executable_only
  depends_on 'libx11' => :executable_only
  depends_on 'libxaw' => :executable_only
  depends_on 'libxext' => :executable_only
  depends_on 'libxft' => :executable_only
  depends_on 'libxinerama' => :executable_only
  depends_on 'libxmu' => :executable_only
  depends_on 'libxpm' => :executable_only
  depends_on 'libxt' => :executable_only
  depends_on 'luit' => :build
  depends_on 'ncurses' => :executable_only
  depends_on 'pcre' => :executable_only
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

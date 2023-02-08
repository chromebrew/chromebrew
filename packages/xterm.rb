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
     aarch64: 'file:///usr/local/tmp/packages/xterm-378c-chromeos-armv7l.tar.zst',
      armv7l: 'file:///usr/local/tmp/packages/xterm-378c-chromeos-armv7l.tar.zst',
        i686: 'file:///usr/local/tmp/packages/xterm-378c-chromeos-i686.tar.zst',
      x86_64: 'file:///usr/local/tmp/packages/xterm-378c-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
     aarch64: '34b81402bedfe9a2a1973f4f9b6033ce0db46076b3409a705a14c5dac912c197',
      armv7l: '34b81402bedfe9a2a1973f4f9b6033ce0db46076b3409a705a14c5dac912c197',
        i686: 'ee9f8a26da34386339529aebbad1a520e82f1f79f1df43d67cbba34d2dccf800',
      x86_64: '6616c699151c4cda0b6f3b1f4808acd5e38d03827a98ccec032228b7b0629ffa'
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
    system "sed -i '/^LDFLAGS/ s/$/ -DUSE_TERMINFO=1 -ltinfo/' Makefile"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
    system "make install-ti DESTDIR=#{CREW_DEST_DIR}"
  end
end

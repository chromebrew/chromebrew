require 'package'

class Xterm < Package
  description 'The xterm program is a terminal emulator for the X Window System.'
  homepage 'https://invisible-island.net/xterm/'
  version '361'
  compatibility 'all'
  source_url "https://invisible-mirror.net/archives/xterm/xterm-361.tgz"
  source_sha256 '85610f20d5e47205cc1b6876f7a4da28d6ae051bd8eac0b932e92c37a73a623f'
  depends_on 'pcre'
  depends_on 'sommelier'

  def self.build
    ENV['TMPDIR'] = "#{CREW_PREFIX}/tmp"
    ENV['PATH'] = '/bin:/sbin:/usr/local/bin' # The /usr/bin need to remove from PATH as bash will point 'tic' to /usr/bin/tic 
    system "./configure",
           "--with-x",
           "--with-pcre",
           "--with-xinerama",
           "--enable-dabbrev",
           "--enable-toolbar",
           "--with-pkg-config",
           "--enable-exec-xterm",
           "--enable-16bit-chars",
           "--enable-dec-locator",
           "--enable-double-buffer",
           "--enable-readline-mouse",
           "--enable-regis-graphics",
           "--enable-sixel-graphics",
           "--prefix=#{CREW_PREFIX}",
           "--with-xpm=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--with-ticlib"
    system "make"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
    system "make install-ti DESTDIR=#{CREW_DEST_DIR}"
  end
end

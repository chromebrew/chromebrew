require 'package'

class Xterm < Package
  description 'The xterm program is a terminal emulator for the X Window System.'
  homepage 'https://invisible-island.net/xterm/'
  version '341-1'
  source_url "https://invisible-mirror.net/archives/xterm/xterm-341.tgz"
  source_sha256 '63a07dfa2b5d501a9e1da0e05772bff7ad431ac2065127c77eebe392ef33cb44'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'pcre'
  depends_on 'sommelier'

  def self.build
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
           "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
    system "make install-ti DESTDIR=#{CREW_DEST_DIR}"
  end
end

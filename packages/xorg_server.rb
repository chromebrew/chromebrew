require 'package'

class Xorg_server < Package
  description 'The Xorg Server is the core of the X Window system.'
  homepage 'https://www.x.org'
  version '1.20.3'
  source_url 'https://www.x.org/releases/individual/xserver/xorg-server-1.20.3.tar.bz2'
  source_sha256 '1b3ce466c12cacbe2252b3ad5b0ed561972eef9d09e75900d65fb1e21f9201de'

  binary_url ({
  })
  binary_sha256 ({
  })


  depends_on 'pixman'
  depends_on 'mesa'
  depends_on 'xorg_lib'
  depends_on 'xorg_proto'
  depends_on 'libepoxy'
  depends_on 'libtirpc'
  depends_on 'font_util'
  depends_on 'libunwind'
  depends_on 'wayland'
  depends_on 'nettle'
  depends_on 'libbsd'
  depends_on 'dbus'
  depends_on 'lzma' => :build
  depends_on 'font_util'
  depends_on 'libxkbcommon'
  depends_on 'xkbcomp'
  
  def self.build
    system "./configure",
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             "--enable-xfree86-utils",
             "--enable-xf86vidmode",
             "--enable-glamor",
             "--enable-xorg",
             "--enable-xwayland",
             "--enable-xvfb",
             "--enable-xnest",
             "--disable-systemd-logind"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "ln", "-sf", "Xwayland", "#{CREW_DEST_PREFIX}/bin/X"
  end
end


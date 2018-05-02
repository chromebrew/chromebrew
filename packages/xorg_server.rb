require 'package'

class Xorg_server < Package
  description 'The Xorg Server is the core of the X Window system.'
  homepage 'https://www.x.org'
  version '1.19.6-1'
  source_url 'https://www.x.org/releases/individual/xserver/xorg-server-1.19.6.tar.bz2'
  source_sha256 'a732502f1db000cf36a376cd0c010ffdbf32ecdd7f1fa08ba7f5bdf9601cc197'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew2/chromebrew2/xorg_server-1.19.6-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew2/chromebrew2/xorg_server-1.19.6-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew2/chromebrew2/xorg_server-1.19.6-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew2/chromebrew2/xorg_server-1.19.6-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd4523423d82ced6f48663fc2f0f124905289b36347cf226e814270a0b9cd90c7',
     armv7l: 'd4523423d82ced6f48663fc2f0f124905289b36347cf226e814270a0b9cd90c7',
       i686: '1a06f9b404cee25a5393484cd7e9457b6fc3986505943ae623d82d18d5a1d3b1',
     x86_64: '77ed3fad1534c65ff69241169785d6d5e365f3d4e8d232e1955853d339f2e6a3',
  })


  depends_on 'pixman'
  depends_on 'mesa'
  depends_on 'xorg_lib'
  depends_on 'xorg_proto'
  depends_on 'libepoxy'
  depends_on 'libtirpc'  # fix rpc.h missing problem
  depends_on 'font_util'
  depends_on 'libunwind'
  depends_on 'libwayland'
  depends_on 'wayland_protocols'
  depends_on 'nettle'
  depends_on 'libbsd'
  depends_on 'dbus'
  depends_on 'lzma'
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
             "--disable-xvfb",
             "--disable-xnest",
             "--disable-systemd-logind",
             "--enable-suid-wrapper"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
  end
end

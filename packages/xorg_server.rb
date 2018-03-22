require 'package'

class Xorg_server < Package
  description 'The Xorg Server is the core of the X Window system.'
  homepage 'https://www.x.org'
  version '1.19.6'
  source_url 'https://www.x.org/releases/individual/xserver/xorg-server-1.19.6.tar.bz2'
  source_sha256 'a732502f1db000cf36a376cd0c010ffdbf32ecdd7f1fa08ba7f5bdf9601cc197'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_server-1.19.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_server-1.19.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_server-1.19.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_server-1.19.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0428359e4080a6b1b331d7e73af726aaab21598ea482f212efc0b9591011847d',
     armv7l: '0428359e4080a6b1b331d7e73af726aaab21598ea482f212efc0b9591011847d',
       i686: 'c5d419b18e50c56ed0da0e9214d0816ae4f4124f1cad0974c51b40d670d06f61',
     x86_64: '5f7191352bf495d3166211d59d9098efc5f231bb7a3f47c3b4f010b2cf2df740',
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
           "--disable-glamor",
           "--enable-xorg",
           "--enable-xwayland",
           "--disable-xvfb",
           "--disable-xnest",
           "--disable-systemd-logind",
           "--enable-suid-wrapper"
  system "make"
end

def self.install
  system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
end
end

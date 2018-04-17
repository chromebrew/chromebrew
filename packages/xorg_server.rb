require 'package'

class Xorg_server < Package
  description 'The Xorg Server is the core of the X Window system.'
  homepage 'https://www.x.org'
  version '1.19.6-0'
  source_url 'https://www.x.org/releases/individual/xserver/xorg-server-1.19.6.tar.bz2'
  source_sha256 'a732502f1db000cf36a376cd0c010ffdbf32ecdd7f1fa08ba7f5bdf9601cc197'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_server-1.19.6-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_server-1.19.6-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_server-1.19.6-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_server-1.19.6-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '52b2e20370b8fcef5fd0315e5e817d70f7907dabef3533ad6cdece634b988064',
     armv7l: '52b2e20370b8fcef5fd0315e5e817d70f7907dabef3533ad6cdece634b988064',
       i686: '5066413429e3b561679398f23fa5c3d3bf23cbf2de92cbe64e6149c6d7594955',
     x86_64: 'ae89f5ad22ddc6b109b9ca224565c3857a499308195df69f294b769ad0edae96',
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
             "--disable-systemd-logind"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

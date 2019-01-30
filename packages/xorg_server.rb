require 'package'

class Xorg_server < Package
  description 'The Xorg Server is the core of the X Window system.'
  homepage 'https://www.x.org'
  version '1.20.3'
  source_url 'https://www.x.org/releases/individual/xserver/xorg-server-1.20.3.tar.bz2'
  source_sha256 '1b3ce466c12cacbe2252b3ad5b0ed561972eef9d09e75900d65fb1e21f9201de'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_server-1.20.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_server-1.20.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_server-1.20.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_server-1.20.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5603c3ad8211c77b9af761cb9ca78493b7a9a4f877197e619235e2892ffba8cc',
     armv7l: '5603c3ad8211c77b9af761cb9ca78493b7a9a4f877197e619235e2892ffba8cc',
       i686: 'cbec00ee50d01ccb2cdae94c2e62a254c6687a8f282ca7af24b625825dfb2958',
     x86_64: 'daeac28c7d97ef2eaff50439cbb83299cf9df6c27a3ec816ffe55b2680b0053b',
  })

  depends_on 'pixman'
  depends_on 'xorg_lib'
  depends_on 'xorg_proto'
  depends_on 'libepoxy'
  depends_on 'libtirpc'
  depends_on 'font_util'
  depends_on 'libunwind'
  depends_on 'libbsd'
  depends_on 'dbus'
  depends_on 'lzma' => :build
  depends_on 'libxkbcommon'
  depends_on 'xkbcomp'
  depends_on 'glproto'

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

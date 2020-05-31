require 'package'

class Xorg_server < Package
  description 'The Xorg Server is the core of the X Window system.'
  homepage 'https://www.x.org'
  version '1.20.7'
  source_url 'https://www.x.org/releases/individual/xserver/xorg-server-1.20.7.tar.bz2'
  source_sha256 'bd5986f010f34f5b3d6bc99fe395ecb1e0dead15a26807e0c832701809a06ea1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_server-1.20.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_server-1.20.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_server-1.20.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_server-1.20.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '311a12cae0c1f03dd40c3605168c0c8928d40fdd2bb6cf42e5d20a6c8a97b6c1',
     armv7l: '311a12cae0c1f03dd40c3605168c0c8928d40fdd2bb6cf42e5d20a6c8a97b6c1',
       i686: '83adbeae700a2f36a5d238094579dd08efb33cc26e63e05d7f60d417d0448810',
     x86_64: '9ef9acf6f82c2815880438a323c1acf5625f1111963fba714c5c3d11697f4959',
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
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-xfree86-utils',
           '--enable-xf86vidmode',
           '--enable-glamor',
           '--enable-xorg',
           '--enable-xwayland',
           '--enable-xvfb',
           '--enable-xnest',
           '--disable-systemd-logind'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.ln_sf 'Xwayland', "#{CREW_DEST_PREFIX}/bin/X"
  end
end

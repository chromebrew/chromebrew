require 'package'

class Xwayland < Package
  description 'X server configured to (only) work with weston'
  homepage 'https://x.org'
  version '1.20.1'
  source_url 'https://www.x.org/releases/individual/xserver/xorg-server-1.20.1.tar.bz2'
  source_sha256 '59c99fe86fe75b8164c6567bfc6e982aecc2e4a51e6fbac1b842d5d00549e918'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xwayland-1.20.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xwayland-1.20.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xwayland-1.20.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xwayland-1.20.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '18a1711d3dc2383ea5ccb515916db9dbe7c1418c8c603da1a4cdd54b3ae3e3e8',
     armv7l: '18a1711d3dc2383ea5ccb515916db9dbe7c1418c8c603da1a4cdd54b3ae3e3e8',
       i686: 'b7ce2f3ba702cd71a03aef6d36c1e739773d8c234db8a25a1e40734f6ad18fd5',
     x86_64: 'b4bad45b9c4a9a7bd34d61c8b31e5a621133ed7cde17b85668c33b4632477f25',
  })

  depends_on 'libepoxy'
  depends_on 'xorg_proto'
  depends_on 'libxtrans'
  depends_on 'libxkbfile'
  depends_on 'wayland'
  depends_on 'eudev'
  depends_on 'libxfont'
  depends_on 'libbsd'
  depends_on 'nettle'
  depends_on 'libtirpc'
  depends_on 'pixman'
  depends_on 'xinit'
  depends_on 'libxkbcommon'
  depends_on 'libunwind'
  depends_on 'font_util'
  depends_on 'glproto'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --disable-docs --disable-devel-docs --enable-xwayland --disable-xorg --disable-xvfb --disable-xnest --disable-xquartz --disable-xwin"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "ln", "-s", "#{CREW_PREFIX}/bin/Xwayland", "#{CREW_DEST_PREFIX}/bin/X"
  end
end

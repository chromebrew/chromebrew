require 'package'

class Xwayland < Package
  description 'X server configured to (only) work with weston'
  homepage 'https://x.org'
  version '1.19.3'
  source_url 'https://www.x.org/releases/individual/xserver/xorg-server-1.19.3.tar.gz'
  source_sha256 '8f93b98f1ac9fbd87515bfe329a069b48bbec98e5329584ab5fbf759a0953b8d'

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

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --disable-docs --disable-devel-docs --enable-xwayland --disable-xorg --disable-xvfb --disable-xnest --disable-xquartz --disable-xwin"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

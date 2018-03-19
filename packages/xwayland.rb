require 'package'

class Xwayland < Package
  description 'X server configured to (only) work with weston'
  homepage 'https://x.org'
  version '1.19.3'
  source_url 'https://www.x.org/releases/individual/xserver/xorg-server-1.19.3.tar.gz'
  source_sha256 '8f93b98f1ac9fbd87515bfe329a069b48bbec98e5329584ab5fbf759a0953b8d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xwayland-1.19.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xwayland-1.19.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xwayland-1.19.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xwayland-1.19.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '970070866e397c7a3a7892c75b32bd30953eb94dac64a06ae317b1bf384600f0',
     armv7l: '970070866e397c7a3a7892c75b32bd30953eb94dac64a06ae317b1bf384600f0',
       i686: '267d1ec1a05f2fb4270d74e974b4930db6020c6517a14fd6fa30ab26229bba39',
     x86_64: 'c0203fb4c8c9fe1afab893f383e58aa335cf3f0646acbe1440cf85b3d82c70ed',
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

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --disable-docs --disable-devel-docs --enable-xwayland --disable-xorg --disable-xvfb --disable-xnest --disable-xquartz --disable-xwin"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

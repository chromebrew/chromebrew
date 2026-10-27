require 'buildsystems/autotools'

class Xorg_nouveau_driver < Autotools
  description 'The Xorg Nouveau Driver package contains the X.Org Video Driver for NVidia Cards including RIVA TNT, RIVA TNT2, GeForce 256, QUADRO, GeForce2, QUADRO2, GeForce3, QUADRO DDC, nForce, nForce2, GeForce4, QUADRO4, GeForce FX, QUADRO FX, GeForce 6XXX and GeForce 7xxx chipsets.'
  homepage 'https://01.org/linuxgraphics/'
  version '1.0.18'
  license 'custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/driver/xf86-video-nouveau.git'
  git_hashtag "xf86-video-nouveau-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9d8b4c822e90758b69b3c0b825d3d2eb5c53ee31d854bfb82aca96ea227d9d3d',
     armv7l: '9d8b4c822e90758b69b3c0b825d3d2eb5c53ee31d854bfb82aca96ea227d9d3d',
     x86_64: '7410359648d22b2194510a6a26b36c2782999a01160d9cc7617b4202fa2f42bd'
  })

  depends_on 'eudev' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libdrm' => :library
  depends_on 'xorg_server' => :build

  # The new “Maxwell” and “Pascal” GPUs require Glamor to be built with the Xorg server.

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-strip'
  end
end

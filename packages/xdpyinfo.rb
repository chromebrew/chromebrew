require 'buildsystems/autotools'

class Xdpyinfo < Autotools
  description 'Display information utility for X'
  homepage 'https://xorg.freedesktop.org/wiki/'
  version '1.4.0'
  license 'MIT-with-advertising'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xdpyinfo.git'
  git_hashtag "xdpyinfo-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2faca8909ba01d4f05e0c3bd6eff944f8ed7251d7583b2d8a71c68b2061e804c',
     armv7l: '2faca8909ba01d4f05e0c3bd6eff944f8ed7251d7583b2d8a71c68b2061e804c',
     x86_64: '43db5b0f7d7d32505e4348d5c819eab63a3c65f688008e79dc017f033043a85e'
  })

  depends_on 'glibc' # R
  depends_on 'libdmx' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxcomposite' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes'
  depends_on 'libxi' # R
  depends_on 'libxinerama' # R
  depends_on 'libxrender' # R
  depends_on 'libxtst' # R
  depends_on 'libxxf86dga' # R
  depends_on 'libxxf86vm' # R
  depends_on 'xorg_proto' => :build
end

require 'buildsystems/meson'

class Libva < Meson
  description 'Libva is an implementation for VA-API (Video Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  version '2.21.0'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/intel/libva.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e038464e3ad133a7f83f63d4cbf8a369895b3ef5fc2e9e0cba607033261782d0',
     armv7l: 'e038464e3ad133a7f83f63d4cbf8a369895b3ef5fc2e9e0cba607033261782d0',
     x86_64: 'f07fe133986cb9a4fbe598e86f969ac070dc51f46e907f4ff70e9a72691a0424'
  })

  depends_on 'glibc' # R
  depends_on 'libdrm' # R
  depends_on 'libglvnd' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'mesa' # L
  depends_on 'wayland' # R
end

require 'buildsystems/meson'

class Libva < Meson
  description 'Libva is an implementation for VA-API (Video Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  version '2.22.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/intel/libva.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'df90f06f31baa1d5788f74db2e7375d1b55a65139682b462d48ea7d4c2288414',
     armv7l: 'df90f06f31baa1d5788f74db2e7375d1b55a65139682b462d48ea7d4c2288414',
     x86_64: 'd69d1976c650f61712667bdbafecf9a0ca7cf8af250c8d1e0496a31e35031791'
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

require 'buildsystems/meson'

class Libva < Meson
  description 'Libva is an implementation for VA-API (Video Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  version '2.23.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/intel/libva.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8fe3ef3ef6c128d4eb23b5a060f9f55a22c5e5f95b82379d29dff4173b734eb5',
     armv7l: '8fe3ef3ef6c128d4eb23b5a060f9f55a22c5e5f95b82379d29dff4173b734eb5',
     x86_64: 'd3035b4ddbd9c5838c1b825cfd22c2fb7cfcefde0946eb13eab7f20f8d40c597'
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

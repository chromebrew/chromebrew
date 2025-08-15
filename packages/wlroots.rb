require 'buildsystems/meson'

class Wlroots < Meson
  description 'Modular Wayland compositor library'
  homepage 'https://gitlab.freedesktop.org/wlroots/wlroots'
  version '0.19.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/wlroots/wlroots.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a68d642c59f1d81503f18b41c0e2253873f202714d7a4dc8c7265939610ba8e7',
     armv7l: 'a68d642c59f1d81503f18b41c0e2253873f202714d7a4dc8c7265939610ba8e7',
     x86_64: '2193f3d38cec2b6c6c9d77e6425fac31618c9a77de3f5133a01e76edb187009c'
  })

  depends_on 'eudev' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'hwdata' => :build
  depends_on 'libdrm' # R
  depends_on 'libglvnd' # R
  depends_on 'libxcb' # R
  depends_on 'libxkbcommon' # R
  depends_on 'mesa' # R
  depends_on 'pixman' # R
  depends_on 'seatd' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'wayland' # R
  depends_on 'xcb_util_wm' # R
  depends_on 'xwayland'
end

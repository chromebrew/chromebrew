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
    aarch64: '9f4b54300f317f3d3a5b931d1d653e9f6d3e42cd19ccfc2012ef96c6fc6727f4',
     armv7l: '9f4b54300f317f3d3a5b931d1d653e9f6d3e42cd19ccfc2012ef96c6fc6727f4',
     x86_64: '853aa4007613473416064052dd64a55c187eb9bfde0f511e26879cb543e2f341'
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
  depends_on 'vulkan_icd_loader' # R
  depends_on 'wayland' # R
  depends_on 'xcb_util_wm' # R
  depends_on 'xwayland'
end

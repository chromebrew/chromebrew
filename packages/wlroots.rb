require 'buildsystems/meson'

class Wlroots < Meson
  description 'Modular Wayland compositor library'
  homepage 'https://gitlab.freedesktop.org/wlroots/wlroots'
  version '0.20.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/wlroots/wlroots.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8068a8b2872284c4354de03975645b4504d233fb128e8f08a1f95b5b9d95cf07',
     armv7l: '8068a8b2872284c4354de03975645b4504d233fb128e8f08a1f95b5b9d95cf07',
     x86_64: '11cf22ed2e2738e6a6eee06fc1364597ced793378a8d27267b32edea40851da0'
  })

  depends_on 'eudev' => :library
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'glslang' => :library
  depends_on 'hwdata' => :build
  depends_on 'lcms' => :library
  depends_on 'libdrm' => :library
  depends_on 'libglvnd' => :library
  depends_on 'libinput' => :library
  depends_on 'libliftoff' => :library
  depends_on 'libminigbm' => :library
  depends_on 'libxcb' => :library
  depends_on 'libxkbcommon' => :library
  depends_on 'mesa' => :library
  depends_on 'pixman' => :library
  depends_on 'seatd' => :library
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :library
  depends_on 'wayland' => :library
  depends_on 'weston' => :library
  depends_on 'xcb_util_renderutil' => :library
  depends_on 'xcb_util_wm' => :library
  depends_on 'xwayland'
end

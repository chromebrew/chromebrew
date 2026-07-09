require 'buildsystems/meson'

class Wlroots < Meson
  description 'Modular Wayland compositor library'
  homepage 'https://gitlab.freedesktop.org/wlroots/wlroots'
  version '0.20.2'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/wlroots/wlroots.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4aadb998116d6adfba62b87bf1b248d1b0cb4facd90a9e883394cb6cfd6560e0',
     armv7l: '4aadb998116d6adfba62b87bf1b248d1b0cb4facd90a9e883394cb6cfd6560e0',
     x86_64: 'bbb93db2e1e69a312d2d13cac87ce9429cb65c142c291cf42e7f45cd8d0540b6'
  })

  depends_on 'eudev' => :library
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'glslang' => :library
  depends_on 'hwdata' => :build
  depends_on 'lcms' => :library
  depends_on 'libdrm' => :library
  depends_on 'libglvnd' => :library
  depends_on 'libinput' => :library
  depends_on 'libliftoff' => :library
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

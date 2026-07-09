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
    aarch64: 'e270db5a04b83ae07180be9922ed4121b960f2ab25b74a7b59f38fc0952635dd',
     armv7l: 'e270db5a04b83ae07180be9922ed4121b960f2ab25b74a7b59f38fc0952635dd',
     x86_64: '1af3ea4d234c89b61cf062ccea85bceac1401726baba44b6af85221ed99f538e'
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

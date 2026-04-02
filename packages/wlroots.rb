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
    aarch64: '219894cf67dba2b4e30eb0016feb2809029f9704435abf35c4f55f4d2f3310f6',
     armv7l: '219894cf67dba2b4e30eb0016feb2809029f9704435abf35c4f55f4d2f3310f6',
     x86_64: 'b3fc40d28afc2ba1e168983b738c3865529914338737924783f9b936a26f807d'
  })

  depends_on 'eudev' => :library
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'hwdata' => :build
  depends_on 'libdrm' => :library
  depends_on 'libglvnd' => :library
  depends_on 'libxcb' => :library
  depends_on 'libxkbcommon' => :library
  depends_on 'mesa' => :library
  depends_on 'pixman' => :library
  depends_on 'seatd' => :library
  depends_on 'vulkan_headers' => :build
  depends_on 'wayland' => :library
  depends_on 'xcb_util_wm' => :library
  depends_on 'xwayland'
end

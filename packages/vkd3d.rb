require 'buildsystems/autotools'

class Vkd3d < Autotools
  description 'Vkd3d is a 3D graphics library built on top of Vulkan. It has an API very similar, but not identical, to Direct3D 12.'
  homepage 'https://wiki.winehq.org/Vkd3d/'
  version '1.11'
  license 'LGPL-2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.winehq.org/wine/vkd3d.git'
  git_hashtag "vkd3d-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '022d7e9e7e15a2546b462f46b2c79b477b46581204b80ea81ef8e1317b145320',
     armv7l: '022d7e9e7e15a2546b462f46b2c79b477b46581204b80ea81ef8e1317b145320',
     x86_64: '6ea8560991499d40a425e4f5a64a4c61fdd26c68256eb6d30c168211519f84ef'
  })

  depends_on 'glibc' # R
  depends_on 'libxcb' => :build
  depends_on 'ncurses' # R
  depends_on 'spirv_headers' => :build
  depends_on 'spirv_tools' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build
  depends_on 'wine' => :build
  no_lto

  configure_options '--with-xcb \
            --with-spirv-tools'
end

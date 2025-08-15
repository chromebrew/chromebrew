require 'buildsystems/autotools'

class Vkd3d < Autotools
  description 'Vkd3d is a 3D graphics library built on top of Vulkan. It has an API very similar, but not identical, to Direct3D 12.'
  homepage 'https://wiki.winehq.org/Vkd3d/'
  version '1.16'
  license 'LGPL-2.1'
  compatibility 'x86_64'
  source_url 'https://gitlab.winehq.org/wine/vkd3d.git'
  git_hashtag "vkd3d-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '640dbf6451815908b51e438d3f48bacf032881cb17ee804c94ddf2da84e8e208'
  })

  depends_on 'glibc' # R
  depends_on 'libxcb' => :build
  depends_on 'ncurses' # R
  depends_on 'perl_json' => :build
  depends_on 'spirv_headers' => :build
  depends_on 'spirv_tools' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build
  depends_on 'wine' => :build

  no_lto

  autotools_configure_options '--with-xcb \
            --with-spirv-tools'
end

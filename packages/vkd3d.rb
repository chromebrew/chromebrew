require 'buildsystems/autotools'

class Vkd3d < Autotools
  description 'Vkd3d is a 3D graphics library built on top of Vulkan. It has an API very similar, but not identical, to Direct3D 12.'
  homepage 'https://wiki.winehq.org/Vkd3d/'
  version '1.19'
  license 'LGPL-2.1'
  compatibility 'x86_64'
  source_url 'https://gitlab.winehq.org/wine/vkd3d.git'
  git_hashtag "vkd3d-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '9f6f5f8c93d0796e4a2878107b507d9cd075b44f264c64797ad7dc64ee708684'
  })

  depends_on 'glibc' => :library
  depends_on 'libxcb' => :build
  depends_on 'ncurses' => :executable
  depends_on 'perl_json' => :build
  depends_on 'spirv_headers' => :build
  depends_on 'spirv_tools' => :library
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build
  depends_on 'wine' => :build

  no_lto

  autotools_configure_options '--with-xcb --with-spirv-tools'
end

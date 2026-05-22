require 'buildsystems/autotools'

class Vkd3d < Autotools
  description 'Vkd3d is a 3D graphics library built on top of Vulkan. It has an API very similar, but not identical, to Direct3D 12.'
  homepage 'https://wiki.winehq.org/Vkd3d/'
  version '2.0'
  license 'LGPL-2.1'
  compatibility 'x86_64'
  source_url 'https://gitlab.winehq.org/wine/vkd3d.git'
  git_hashtag "vkd3d-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '9d451383c82c1c46b7306b7a5c5075cc0ff52c987f4fb74901fffe804cfeaa11'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libxcb' => :build
  depends_on 'ncurses' => :executable
  depends_on 'perl_json' => :build
  depends_on 'shaderc' => :library
  depends_on 'spirv_headers' => :build
  depends_on 'spirv_tools' => :library
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build
  depends_on 'vulkansdk' => :library
  depends_on 'wine' => :build

  no_lto

  autotools_configure_options '--with-xcb --with-spirv-tools'
end

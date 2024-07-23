# Adapted from Arch Linux libplacebo PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libplacebo/trunk/PKGBUILD

require 'buildsystems/meson'

class Libplacebo < Meson
  description 'Reusable library for GPU-accelerated video/image rendering primitives'
  homepage 'https://github.com/haasn/libplacebo'
  version '6.338.2'
  license 'LGPL2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://code.videolan.org/videolan/libplacebo.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bb12747b29b7d0bbb5b52ff6baca27e274d7655280d408c8727c1be6685661cc',
     armv7l: 'bb12747b29b7d0bbb5b52ff6baca27e274d7655280d408c8727c1be6685661cc',
     x86_64: '50a4cad52230a458f8bbe3137d52bfb8200b7b965deb8cdc6b2a8fcd58d15896'
  })

  depends_on 'vulkan_icd_loader' => :build
  depends_on 'glslang' => :build
  depends_on 'lcms' => :build
  depends_on 'libdovi' => :build
  depends_on 'shaderc' => :build

  meson_options "-Dtests=false \
    -Dvulkan=enabled \
    -Dglslang=enabled \
    -Dshaderc=enabled \
    -Dlcms=enabled \
    -Dd3d11=disabled \
    -Ddemos=false"
end

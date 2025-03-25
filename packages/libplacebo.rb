# Adapted from Arch Linux libplacebo PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libplacebo/trunk/PKGBUILD

require 'buildsystems/meson'

class Libplacebo < Meson
  description 'Reusable library for GPU-accelerated video/image rendering primitives'
  homepage 'https://github.com/haasn/libplacebo'
  version '7.349.0-16ef0a2'
  license 'LGPL2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://code.videolan.org/videolan/libplacebo.git'
  git_hashtag '16ef0a2685d371468a0e8139beac07650915ff38'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bb12747b29b7d0bbb5b52ff6baca27e274d7655280d408c8727c1be6685661cc',
     armv7l: 'bb12747b29b7d0bbb5b52ff6baca27e274d7655280d408c8727c1be6685661cc',
     x86_64: '50a4cad52230a458f8bbe3137d52bfb8200b7b965deb8cdc6b2a8fcd58d15896'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glslang' # R
  depends_on 'shaderc' # R
  depends_on 'lcms' # R
  depends_on 'libdovi' # R
  depends_on 'vulkan_icd_loader' # R

  meson_options "-Dtests=false \
    -Dvulkan=enabled \
    -Dglslang=enabled \
    -Dshaderc=enabled \
    -Dlcms=enabled \
    -Dd3d11=disabled \
    -Ddemos=false"
end

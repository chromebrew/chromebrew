# Adapted from Arch Linux libplacebo PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libplacebo/trunk/PKGBUILD

require 'buildsystems/meson'

class Libplacebo < Meson
  description 'Reusable library for GPU-accelerated video/image rendering primitives'
  homepage 'https://github.com/haasn/libplacebo'
  version '7.387.0'
  license 'LGPL2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://code.videolan.org/videolan/libplacebo.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '18400a406c0be5ade768c674925804342594040601d5695cfc7ec0a97dfa9fb9',
     armv7l: '18400a406c0be5ade768c674925804342594040601d5695cfc7ec0a97dfa9fb9',
     x86_64: 'd7ca271df1fa2f474e644b661828fc1035652ea88986dec3cee1c975c5537209'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'glslang' => :library
  depends_on 'lcms' => :library
  depends_on 'libdovi' => :library
  depends_on 'shaderc' => :library
  depends_on 'vulkan_icd_loader' => :library
  depends_on 'vulkansdk' => :library

  meson_options "-Dtests=false \
    -Dvulkan=enabled \
    -Dglslang=enabled \
    -Dshaderc=enabled \
    -Dlcms=enabled \
    -Dd3d11=disabled \
    -Ddemos=false"
end

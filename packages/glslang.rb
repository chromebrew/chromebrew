# Adapted from Arch Linux glslang PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/glslang/trunk/PKGBUILD

require 'buildsystems/cmake'

class Glslang < CMake
  description 'OpenGL and OpenGL ES shader front end and validator'
  homepage 'https://github.com/KhronosGroup/glslang'
  version '16.2.0'
  license 'BSD-3, MIT, BSD-2, Apache-2.0 and NVIDIA'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/glslang.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c0aa4ef070c4cd58d7eb8aec2e7149327fe3ac709b38b27173f98bf1c61d8070',
     armv7l: 'c0aa4ef070c4cd58d7eb8aec2e7149327fe3ac709b38b27173f98bf1c61d8070',
     x86_64: 'f332064f46f60f3323fa542761abd37972ca7c6e9e263c64137c0ed3743438ae'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'spirv_headers' => :build
  depends_on 'spirv_tools' # R

  cmake_options "-DBUILD_SHARED_LIBS=ON \
      -DALLOW_EXTERNAL_SPIRV_TOOLS=ON \
      -DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX}"
end

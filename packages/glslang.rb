# Adapted from Arch Linux glslang PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/glslang/trunk/PKGBUILD

require 'buildsystems/cmake'

class Glslang < CMake
  description 'OpenGL and OpenGL ES shader front end and validator'
  homepage 'https://github.com/KhronosGroup/glslang'
  version '16.3.0'
  license 'BSD-3, MIT, BSD-2, Apache-2.0 and NVIDIA'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/glslang.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dab4b0802c22ece148b53b57959ca639374d900d5bc53a1ddf9e8a9dd8fff65d',
     armv7l: 'dab4b0802c22ece148b53b57959ca639374d900d5bc53a1ddf9e8a9dd8fff65d',
     x86_64: '0e304ae4ef16fc9220901f5274cc22d0592c101f65631aea9e22b013e6eb9898'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'spirv_headers' => :build
  depends_on 'spirv_tools' => :library

  cmake_options "-DBUILD_SHARED_LIBS=ON \
      -DALLOW_EXTERNAL_SPIRV_TOOLS=ON \
      -DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX}"
end

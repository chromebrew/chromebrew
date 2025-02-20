# Adapted from Arch Linux glslang PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/glslang/trunk/PKGBUILD

require 'buildsystems/cmake'

class Glslang < CMake
  description 'OpenGL and OpenGL ES shader front end and validator'
  homepage 'https://github.com/KhronosGroup/glslang'
  version '15.1.0'
  license 'BSD-3, MIT, BSD-2, Apache-2.0 and NVIDIA'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/glslang.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ceba7382d468819b2254665bdd4935a9f55c27d15624076cf843bc6d72c744f9',
     armv7l: 'ceba7382d468819b2254665bdd4935a9f55c27d15624076cf843bc6d72c744f9',
     x86_64: '08c4f8d3a1487dcaf27d90fa9a2d01374a44b7bc45a20c2312038909e5986f9a'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'spirv_headers' => :build
  depends_on 'spirv_tools' # R

  cmake_options "-DBUILD_SHARED_LIBS=ON \
      -DALLOW_EXTERNAL_SPIRV_TOOLS=ON \
      -DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX}"
end

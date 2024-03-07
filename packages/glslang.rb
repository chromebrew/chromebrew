# Adapted from Arch Linux glslang PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/glslang/trunk/PKGBUILD

require 'buildsystems/cmake'

class Glslang < CMake
  description 'OpenGL and OpenGL ES shader front end and validator'
  homepage 'https://github.com/KhronosGroup/glslang'
  version '14.0.0-bada5c8'
  license 'BSD-3, MIT, BSD-2, Apache-2.0 and NVIDIA'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/KhronosGroup/glslang.git'
  git_hashtag 'bada5c87ec6db4441db129d8506742c4a72bd610'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7462ef838ed52f456a820fc0a1475148506a1a230f5f9ab54fc7bcdfe30a35aa',
     armv7l: '7462ef838ed52f456a820fc0a1475148506a1a230f5f9ab54fc7bcdfe30a35aa',
     x86_64: 'ef0a720e22567f8d14b2ed5dc14b5c489c4b5f5d9327847519b8299bf063fb19'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'spirv_headers' => :build
  depends_on 'spirv_tools' # R

  cmake_options "-DBUILD_SHARED_LIBS=ON \
      -DALLOW_EXTERNAL_SPIRV_TOOLS=ON \
      -DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX}"
end

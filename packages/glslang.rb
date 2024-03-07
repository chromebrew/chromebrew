# Adapted from Arch Linux glslang PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/glslang/trunk/PKGBUILD

require 'buildsystems/cmake'

class Glslang < CMake
  description 'OpenGL and OpenGL ES shader front end and validator'
  homepage 'https://github.com/KhronosGroup/glslang'
  version '14.0.0'
  license 'BSD-3, MIT, BSD-2, Apache-2.0 and NVIDIA'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/KhronosGroup/glslang.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3e751f7dd531c74756289df26b246b60ccbc366acdfe858fed75f0110fed70df',
     armv7l: '3e751f7dd531c74756289df26b246b60ccbc366acdfe858fed75f0110fed70df',
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

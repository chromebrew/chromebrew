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
    aarch64: 'd56db244e1e6178c97608af789c1a30f649885225aae8062a02178caf30bb5a8',
     armv7l: 'd56db244e1e6178c97608af789c1a30f649885225aae8062a02178caf30bb5a8',
     x86_64: 'cdee878c3b18ed1091b08d24defc57fb08b2b420348d43248d0c3ced29651070'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'spirv_headers' => :build
  depends_on 'spirv_tools' # R

  cmake_options "-DBUILD_SHARED_LIBS=ON \
      -DALLOW_EXTERNAL_SPIRV_TOOLS=ON \
      -DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX}"
end

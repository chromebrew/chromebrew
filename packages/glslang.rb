# Adapted from Arch Linux glslang PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/glslang/trunk/PKGBUILD

require 'buildsystems/cmake'

class Glslang < CMake
  description 'OpenGL and OpenGL ES shader front end and validator'
  homepage 'https://github.com/KhronosGroup/glslang'
  version '16.5.0'
  license 'BSD-3, MIT, BSD-2, Apache-2.0 and NVIDIA'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/glslang.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4a75cd70d70cc2cd39dfd0cf81f5464035f2b2c455b4ee552299aa0ac0338d29',
     armv7l: '4a75cd70d70cc2cd39dfd0cf81f5464035f2b2c455b4ee552299aa0ac0338d29',
     x86_64: '8fda6258987983e0c29215ba4f7cc146d6c6033d4e9fa54cdf9540bdc3a7f504'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'spirv_headers' => :build
  depends_on 'spirv_tools' => :library

  cmake_options "-DBUILD_SHARED_LIBS=ON \
      -DALLOW_EXTERNAL_SPIRV_TOOLS=ON \
      -DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX}"
end

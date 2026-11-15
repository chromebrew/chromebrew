# Adapted from Arch Linux shaderc PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/shaderc/trunk/PKGBUILD

require 'buildsystems/cmake'

class Shaderc < CMake
  description 'Collection of tools, libraries and tests for shader compilation'
  homepage 'https://github.com/google/shaderc'
  version '2026.4'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/google/shaderc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6578ff90fa9d693b6b875245bca7bb19defa0fda969ad0efdcb0cb325ac13b25',
     armv7l: '6578ff90fa9d693b6b875245bca7bb19defa0fda969ad0efdcb0cb325ac13b25',
     x86_64: 'eada61a82bc79603b70a2500b9b1188bdc2ff9e875cdf7a867a811692cb27ef8'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'glslang' => :library
  depends_on 'ruby_asciidoctor' => :build
  depends_on 'spirv_headers' => :build
  depends_on 'spirv_tools' => :library

  conflicts_ok # conflicts with glslang

  def self.patch
    system './utils/git-sync-deps'
  end

  cmake_options '-DSPIRV_WERROR=Off \
        -DBUILD_SHARED_LIBS=ON \
        -DSHADERC_SKIP_TESTS=ON \
        -DSHADERC_ENABLE_EXAMPLES=OFF'
end

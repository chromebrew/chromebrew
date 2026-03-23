# Adapted from Arch Linux shaderc PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/shaderc/trunk/PKGBUILD

require 'buildsystems/cmake'

class Shaderc < CMake
  description 'Collection of tools, libraries and tests for shader compilation'
  homepage 'https://github.com/google/shaderc'
  version '2026.1'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/google/shaderc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd6b0ba5835b5b2d69d8aed52f1e6c3756fdb91087893a9b3697f963d260d1d16',
     armv7l: 'd6b0ba5835b5b2d69d8aed52f1e6c3756fdb91087893a9b3697f963d260d1d16',
     x86_64: 'c7115e3ce3dcefa529e96cb5e79d642f8109454a78adc097bc00feb115c8b60e'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
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

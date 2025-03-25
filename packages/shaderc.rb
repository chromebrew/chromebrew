# Adapted from Arch Linux shaderc PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/shaderc/trunk/PKGBUILD

require 'buildsystems/cmake'

class Shaderc < CMake
  description 'Collection of tools, libraries and tests for shader compilation'
  homepage 'https://github.com/google/shaderc'
  version '2025.1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/google/shaderc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c21288bcfcc9f477a938a4a3a33c1bc9c8b44d473363547cce3dd6af5d91714',
     armv7l: '0c21288bcfcc9f477a938a4a3a33c1bc9c8b44d473363547cce3dd6af5d91714',
       i686: 'd0b7a92f5021b97f5c9e0ec229acae6f2820b8b38a037755c526328458442c7c',
     x86_64: '981a43dee48b92467c019941b665c6f5844e86c1b7b6ef81e11bbc345683ac10'
  })

  depends_on 'ruby_asciidoctor' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glslang' # R
  depends_on 'spirv_headers' => :build
  depends_on 'spirv_tools' # R

  def self.patch
    system './utils/git-sync-deps'
  end

  cmake_options '-DSPIRV_WERROR=Off \
        -DBUILD_SHARED_LIBS=ON \
        -DSHADERC_SKIP_TESTS=ON \
        -DSHADERC_ENABLE_EXAMPLES=OFF'
end

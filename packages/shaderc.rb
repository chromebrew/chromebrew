# Adapted from Arch Linux shaderc PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/shaderc/trunk/PKGBUILD

require 'buildsystems/cmake'

class Shaderc < CMake
  description 'Collection of tools, libraries and tests for shader compilation'
  homepage 'https://github.com/google/shaderc'
  version '2025.4'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/google/shaderc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '10afd6df640941542e19f92760a8f55895f080949072ac7df1f46ba4456fa627',
     armv7l: '10afd6df640941542e19f92760a8f55895f080949072ac7df1f46ba4456fa627',
       i686: 'd0b7a92f5021b97f5c9e0ec229acae6f2820b8b38a037755c526328458442c7c',
     x86_64: '00db20c22ac98f17becaf9f8d628b8b50eac78f22011666cd7a63f99dfb24110'
  })

  depends_on 'ruby_asciidoctor' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glslang' # R
  depends_on 'spirv_headers' => :build
  depends_on 'spirv_tools' # R

  conflicts_ok # conflicts with glslang

  def self.patch
    system './utils/git-sync-deps'
  end

  cmake_options '-DSPIRV_WERROR=Off \
        -DBUILD_SHARED_LIBS=ON \
        -DSHADERC_SKIP_TESTS=ON \
        -DSHADERC_ENABLE_EXAMPLES=OFF'
end

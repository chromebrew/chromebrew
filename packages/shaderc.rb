# Adapted from Arch Linux shaderc PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/shaderc/trunk/PKGBUILD

require 'buildsystems/cmake'

class Shaderc < CMake
  description 'Collection of tools, libraries and tests for shader compilation'
  homepage 'https://github.com/google/shaderc'
  version '2026.2'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/google/shaderc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd2685cf0ed8a5b820c321d0470b56153a4f7df9dd1bd2796456c1f243a888a02',
     armv7l: 'd2685cf0ed8a5b820c321d0470b56153a4f7df9dd1bd2796456c1f243a888a02',
     x86_64: '34bc32b9cdd6cba70007050e8a83daa467ac8fcafb7eeed9bc7005028fd887a3'
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

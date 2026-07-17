# Adapted from Arch Linux shaderc PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/shaderc/trunk/PKGBUILD

require 'buildsystems/cmake'

class Shaderc < CMake
  description 'Collection of tools, libraries and tests for shader compilation'
  homepage 'https://github.com/google/shaderc'
  version '2026.3'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/google/shaderc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a6a441fe5a067a15b3f482ea3c01234ab2439b3e2a5655b8d915afe44e4fa3bc',
     armv7l: 'a6a441fe5a067a15b3f482ea3c01234ab2439b3e2a5655b8d915afe44e4fa3bc',
     x86_64: 'e855570319ea6ebb0f839e261452d9ec11d08a3475fee0791e1afe974db6fe58'
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

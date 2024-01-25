# Adapted from Arch Linux spirv-tools PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/spirv-tools/trunk/PKGBUILD
require 'buildsystems/cmake'

class Spirv_tools < CMake
  homepage 'https://github.com/KhronosGroup/SPIRV-Tools'
  description 'API and commands for processing SPIR-V modules'
  version '2023.6.rc1'
  license 'custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/KhronosGroup/SPIRV-Tools.git'
  git_hashtag "v#{version}"

  binary_sha256({
    aarch64: 'd925a80ea99206946477c5c6223629c06bbad55981da677e2ab54bbee23d843b',
     armv7l: 'd925a80ea99206946477c5c6223629c06bbad55981da677e2ab54bbee23d843b',
     x86_64: '26a772a1baadd956f875e2c9db1e371b068caf8e4546e7884965294882603974'
  })
  binary_compression 'tar.zst'

  depends_on 'spirv_headers' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  git_fetchtags
  no_lto

  def self.patch
    system 'utils/git-sync-deps'
  end

  cmake_options '-DSPIRV_WERROR=Off \
      -DSPIRV_TOOLS_BUILD_STATIC=OFF \
      -DSPIRV_SKIP_TESTS=ON \
      -DBUILD_SHARED_LIBS=ON'
end

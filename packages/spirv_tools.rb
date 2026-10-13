require 'buildsystems/cmake'

class Spirv_tools < CMake
  homepage 'https://github.com/KhronosGroup/SPIRV-Tools'
  description 'API and commands for processing SPIR-V modules'
  version '2026.4'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-Tools.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4e3e50eb85b00a97adcb644202646f788e1d2c0f665facaaab2fc9f0159c4a53',
     armv7l: '4e3e50eb85b00a97adcb644202646f788e1d2c0f665facaaab2fc9f0159c4a53',
       i686: 'a49c49066929864f8ef4506cc8911aad1ca4a94f89a176a6668449de9c29d7e8',
     x86_64: 'dc62ce20d7d869874349c43dab21b54af320325bdc566793afa737b12ec97990'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  # depends_on 'spirv_headers' => :build

  # https://github.com/KhronosGroup/SPIRV-Tools/issues/5728
  def self.patch
    system 'utils/git-sync-deps'
  end

  # https://github.com/KhronosGroup/SPIRV-Tools/issues/3909
  cmake_options '-DSPIRV_TOOLS_BUILD_STATIC=OFF -DBUILD_SHARED_LIBS=ON'
  # 1 - spirv-tools-copyrights (Failed)
  # run_tests
end

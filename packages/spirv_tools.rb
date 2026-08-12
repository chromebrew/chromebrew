require 'buildsystems/cmake'

class Spirv_tools < CMake
  homepage 'https://github.com/KhronosGroup/SPIRV-Tools'
  description 'API and commands for processing SPIR-V modules'
  version '2026.3'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-Tools.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f20d236a4cb27d7c77d5b7ec7d59747fa7bac031e9d272b74e0ffe820056667c',
     armv7l: 'f20d236a4cb27d7c77d5b7ec7d59747fa7bac031e9d272b74e0ffe820056667c',
       i686: '2e192d891f6bcf78c04352e3680b36ca8b81fcdb87c4d71c31c66a0056d71fe4',
     x86_64: '403ade161594ae3791160b67e2a08ba23fcd5faba86fc04ca1935d6d6a12ffc9'
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
  run_tests
end

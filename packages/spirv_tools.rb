require 'buildsystems/cmake'

class Spirv_tools < CMake
  homepage 'https://github.com/KhronosGroup/SPIRV-Tools'
  description 'API and commands for processing SPIR-V modules'
  version '2024.3'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-Tools.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3386f244e3582ba07d6d46d81f834ffa20eca9cb8b22a3dbbf3802d032398556',
     armv7l: '3386f244e3582ba07d6d46d81f834ffa20eca9cb8b22a3dbbf3802d032398556',
       i686: '23393d026d53fc52be7b9a02b54e37ac057662939e57c0eec9037ed38de4e28d',
     x86_64: '0810c092de66488afe89970578b493295b00d310264a249bcf6c4641eb439f13'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  # depends_on 'spirv_headers' => :build
  depends_on 'glibc_lib' # R

  # https://github.com/KhronosGroup/SPIRV-Tools/issues/5728
  def self.patch
    system 'utils/git-sync-deps'
  end

  # https://github.com/KhronosGroup/SPIRV-Tools/issues/3909
  cmake_options '-DSPIRV_TOOLS_BUILD_STATIC=OFF -DBUILD_SHARED_LIBS=ON'
  run_tests
end

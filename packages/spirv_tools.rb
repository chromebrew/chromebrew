require 'buildsystems/cmake'

class Spirv_tools < CMake
  homepage 'https://github.com/KhronosGroup/SPIRV-Tools'
  description 'API and commands for processing SPIR-V modules'
  version '2025.4'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-Tools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '86ef3f869e313b5163a228b6d3fbc99d3f050f7bef2b61c984e64376c9ebc5bc',
     armv7l: '86ef3f869e313b5163a228b6d3fbc99d3f050f7bef2b61c984e64376c9ebc5bc',
       i686: 'b954f445be372ff959c7b2e4de9e0f5e9fb347e07ee80978bb9fd9ece284f309',
     x86_64: '507a4bd4b792814af5b883537569ced617b1502676abf0130a88b613916fb664'
  })

  # depends_on 'spirv_headers' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  # https://github.com/KhronosGroup/SPIRV-Tools/issues/5728
  def self.patch
    system 'utils/git-sync-deps'
  end

  # https://github.com/KhronosGroup/SPIRV-Tools/issues/3909
  cmake_options '-DSPIRV_TOOLS_BUILD_STATIC=OFF -DBUILD_SHARED_LIBS=ON'
  run_tests
end

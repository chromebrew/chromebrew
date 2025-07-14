require 'buildsystems/cmake'

class Spirv_tools < CMake
  homepage 'https://github.com/KhronosGroup/SPIRV-Tools'
  description 'API and commands for processing SPIR-V modules'
  version '2025.1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-Tools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f605f3c1568b267b89972d04e551837a54ca981aeabfba86bae2bee982b26530',
     armv7l: 'f605f3c1568b267b89972d04e551837a54ca981aeabfba86bae2bee982b26530',
       i686: '706f19aebabb24ee20d3f96a9d5e2e607c9437e52ad6931b251e7c23475bdcd9',
     x86_64: '90a756098b6923c475398ef700b577216cc63b765a1b871bbc62e3abe6c7ec00'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  # depends_on 'spirv_headers' => :build

  # https://github.com/KhronosGroup/SPIRV-Tools/issues/5728
  def self.patch
    system 'utils/git-sync-deps'
  end

  # https://github.com/KhronosGroup/SPIRV-Tools/issues/3909
  cmake_options '-DSPIRV_TOOLS_BUILD_STATIC=OFF -DBUILD_SHARED_LIBS=ON'
  run_tests
end

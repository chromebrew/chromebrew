require 'buildsystems/cmake'

class Spirv_tools < CMake
  homepage 'https://github.com/KhronosGroup/SPIRV-Tools'
  description 'API and commands for processing SPIR-V modules'
  version '2026.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-Tools.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '394a8095d66a75219143abbf36fdc925522fcfe69900ac1a8f54d376be6b1d9c',
     armv7l: '394a8095d66a75219143abbf36fdc925522fcfe69900ac1a8f54d376be6b1d9c',
       i686: 'c036524f31851de8edeeb8b14b892e3788357c809887d3cd8c1aa8c3c6fc74c6',
     x86_64: 'e75b797f894165a7a86f6743744365c1780e80b39c3350fb1d7a7a16459b131c'
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

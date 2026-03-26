require 'buildsystems/cmake'

class Spirv_tools < CMake
  homepage 'https://github.com/KhronosGroup/SPIRV-Tools'
  description 'API and commands for processing SPIR-V modules'
  version '2026.1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-Tools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4866ac0ff4b59833540deb7afb1415d31a079cac83a779d18e3183af32ce3a3a',
     armv7l: '4866ac0ff4b59833540deb7afb1415d31a079cac83a779d18e3183af32ce3a3a',
       i686: '9f72b6727b01c0c9d4ca3c90adca2e340db8189c75fdab61cb693819b4c016c2',
     x86_64: '1e7e7181a7870632bd66bea77fd217b3a275cd10eeecbc88861762c52c436c40'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  # depends_on 'spirv_headers' => :build

  # https://github.com/KhronosGroup/SPIRV-Tools/issues/5728
  def self.patch
    system 'utils/git-sync-deps'
  end

  # https://github.com/KhronosGroup/SPIRV-Tools/issues/3909
  cmake_options '-DSPIRV_TOOLS_BUILD_STATIC=OFF -DBUILD_SHARED_LIBS=ON'
  run_tests
end

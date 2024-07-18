require 'buildsystems/cmake'

class Spirv_tools < CMake
  homepage 'https://github.com/KhronosGroup/SPIRV-Tools'
  description 'API and commands for processing SPIR-V modules'
  version '2024.3-1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-Tools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '52a58053473626c4d8e6adbb3d58e353ea8468c63d4b481ec827dd8905a006e4',
     armv7l: '52a58053473626c4d8e6adbb3d58e353ea8468c63d4b481ec827dd8905a006e4',
       i686: 'ccb2da56af36c69d66548acc33d5d13cb816e9698fbfa8d69ba1e853e1e4da16',
     x86_64: '21eafdec332b855639c05586fffa18f6719ff3ae63573e86a659a72799ae8887'
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

require 'buildsystems/cmake'

class Spirv_tools < CMake
  homepage 'https://github.com/KhronosGroup/SPIRV-Tools'
  description 'API and commands for processing SPIR-V modules'
  version '2024.4.rc2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-Tools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7939e964743991dc60d140859ea60c536b2bba9e3c07b25d581aeae9fde28e60',
     armv7l: '7939e964743991dc60d140859ea60c536b2bba9e3c07b25d581aeae9fde28e60',
       i686: '78e150f81274d2476b562c5f78fb6e3242919d296f56a1f6a0ba43487cc48030',
     x86_64: '37edb9d50977d2d88dbb0ce20a0cd32a84a519f309f8991d6c6bcc6f9e190f17'
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

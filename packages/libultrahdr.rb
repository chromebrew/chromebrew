require 'buildsystems/cmake'

class Libultrahdr < CMake
  description 'libultrahdr is an image compression library that uses gain map technology to store and distribute HDR images.'
  homepage 'https://github.com/google/libultrahdr'
  version '1.4.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/google/libultrahdr.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a423ab42017e18458c58b0a47a0501cb4a2cab26f1d77ebf3819454e831a7237',
     armv7l: 'a423ab42017e18458c58b0a47a0501cb4a2cab26f1d77ebf3819454e831a7237',
       i686: 'fbb704a1bac9129e35f6b8e8e34377488b41357e6c834d3a6824fc550f85d624',
     x86_64: 'e966d7fa15f6cfdc5a91133eddd0f36f80116fd91cc63918e430f1a12ae62cf7'
  })

  depends_on 'libjpeg_turbo'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DUHDR_BUILD_EXAMPLES=OFF'
end

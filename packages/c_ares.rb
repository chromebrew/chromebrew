require 'buildsystems/cmake'

class C_ares < CMake
  description 'C library for asynchronous DNS requests (including name resolves).'
  homepage 'https://c-ares.org/'
  version '1.34.5'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/c-ares/c-ares.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a68372896327955ce94af0456d0389a160c4693175de07a56caa7f823973524b',
     armv7l: 'a68372896327955ce94af0456d0389a160c4693175de07a56caa7f823973524b',
       i686: 'f5d7317b9e8de227905e47b8bdb652541b7bb55f4674042117d678701a9f789e',
     x86_64: '04725b31a65337a3efea60462408565709b75ad7f6c3fcf0ca3fdcfb40c6c2f7'
  })

  depends_on 'docbook2x' => :build
  depends_on 'glibc' # R

  cmake_options '-DCARES_BUILD_TESTS=OFF \
      -DCARES_BUILD_TOOLS=ON'
end

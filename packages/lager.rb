require 'buildsystems/cmake'

class Lager < CMake
  description 'C++ library for value-oriented design using the unidirectional data-flow architecture'
  homepage 'https://github.com/arximboldi/lager'
  version '0.1.1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/arximboldi/lager.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e623c6f059f430a10eb9ad4edc148d1b2b0b3fadcac4e532836c8903edc6af3d',
     armv7l: 'e623c6f059f430a10eb9ad4edc148d1b2b0b3fadcac4e532836c8903edc6af3d',
       i686: '90a36c7ed4ad6accdd045d214ebb88e9962725f814858d3068605ba412014afc',
     x86_64: '2ed346288a1e1e9481f5b02a300ab8dc950137987a28c808eae11b376580f6dd'
  })

  cmake_options '-Dlager_BUILD_EXAMPLES=OFF -Dlager_BUILD_TESTS=OFF'
end

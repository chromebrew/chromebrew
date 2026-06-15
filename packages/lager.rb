require 'buildsystems/cmake'

class Lager < CMake
  description 'C++ library for value-oriented design using the unidirectional data-flow architecture'
  homepage 'https://github.com/arximboldi/lager'
  version '0.1.3'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/arximboldi/lager.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8231ec4d87e6cd3aad2278925e60364fd6d024a048cad785cb1f49dda18b43e5',
     armv7l: '8231ec4d87e6cd3aad2278925e60364fd6d024a048cad785cb1f49dda18b43e5',
       i686: '612ccf9403f3088fe9193a98daf86a75cae8f76312465558aad95bb318e19de8',
     x86_64: '3bef496ed97b601fb03fffa8832b6b6be52bfeec5b09045fed9df2f50a4a6c88'
  })

  cmake_options '-Dlager_BUILD_EXAMPLES=OFF -Dlager_BUILD_TESTS=OFF'
end

require 'buildsystems/cmake'

class Zug < CMake
  description 'Transducers for C++'
  homepage 'https://github.com/arximboldi/zug'
  version '0.1.2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/arximboldi/zug.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1079c96d027728edd61760520d7163af033828132779114969f0ddadb7c6f6f6',
     armv7l: '1079c96d027728edd61760520d7163af033828132779114969f0ddadb7c6f6f6',
       i686: 'eb5c43b689efb1632813e3abd8b4bb89729b120d98a8a1852098999c173b52c1',
     x86_64: '0c81c1bacee34b675ce8384a3eeefe067c0294d046cb7cd9e389813adb1e0faf'
  })

  cmake_options '-Dzug_BUILD_EXAMPLES=OFF -Dzug_BUILD_TESTS=OFF'
end

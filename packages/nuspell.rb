require 'buildsystems/cmake'

class Nuspell < CMake
  description 'Nuspell is a fast and safe spelling checker software program.'
  homepage 'https://nuspell.github.io/'
  version '5.1.3'
  license 'LGPL-3.0, GPL-3.0'
  compatibility 'all'
  source_url 'https://github.com/nuspell/nuspell.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '18ab9d2cb145ca77a7d1de062bb5670ecdc828bc1b23386c35de4f9fd0189de4',
     armv7l: '18ab9d2cb145ca77a7d1de062bb5670ecdc828bc1b23386c35de4f9fd0189de4',
       i686: 'bc3cf76a3daee07e6775293f763a0b45f18f9e4f9f1a87a0a1cdae992d45d857',
     x86_64: '346124fe9a711f4eb3a660532e79b7dc28bd863e2de22df079bcd00e1c095742'
  })

  run_tests
end

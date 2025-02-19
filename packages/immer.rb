require 'buildsystems/cmake'

class Immer < CMake
  description 'Postmodern immutable and persistent data structures for C++'
  homepage 'https://github.com/arximboldi/immer'
  version '0.8.1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/arximboldi/immer.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '18a9da2015ea2abc36e404c7e7d787b27230b8e556765b3bcad3eb938777c47c',
     armv7l: '18a9da2015ea2abc36e404c7e7d787b27230b8e556765b3bcad3eb938777c47c',
       i686: '9342a543a2f945eefbb59ccec61b78686720c569d22a80f12814db45cc6f755d',
     x86_64: '4f5b645748d40dc8e0aed4df36ca50e956c7fee2e37e8b249cae58dc7c5039e0'
  })

  cmake_options '-Dimmer_BUILD_TESTS=OFF -Dimmer_BUILD_EXTRAS=OFF -Dimmer_BUILD_EXAMPLES=OFF'
end

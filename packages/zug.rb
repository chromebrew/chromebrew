require 'buildsystems/cmake'

class Zug < CMake
  description 'Transducers for C++'
  homepage 'https://github.com/arximboldi/zug'
  version '0.1.1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/arximboldi/zug.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e8fa6cc5881b5e7d7a396cbfa25d67620b21801f2a1832b29a3b8c37ad70d86c',
     armv7l: 'e8fa6cc5881b5e7d7a396cbfa25d67620b21801f2a1832b29a3b8c37ad70d86c',
       i686: '47504fd456582c53a1e08b9dd4f74dcb8a828cd1926733d50b426f214074a0d8',
     x86_64: 'dfaf133c57e60c8218cd3738fd3a5faa3896883ec6c56c38bd466f3cc22e6455'
  })

  cmake_options '-Dzug_BUILD_EXAMPLES=OFF -Dzug_BUILD_TESTS=OFF'
end

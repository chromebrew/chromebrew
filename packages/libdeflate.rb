require 'buildsystems/cmake'

class Libdeflate < CMake
  description 'Heavily optimized library for DEFLATE compression and decompression'
  homepage 'https://github.com/ebiggers/libdeflate/'
  version '1.19'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ebiggers/libdeflate.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9c2808b40e8257439943369bf44153758e706f09446b9b92de42391ebb52dd00',
     armv7l: '9c2808b40e8257439943369bf44153758e706f09446b9b92de42391ebb52dd00',
       i686: '0c5306cc7692ae9f5061a5a89e13da1bb1ece3240366238613301e69003c7236',
     x86_64: 'b339d1e1e71fcf0aed63e4ed3cd52a5b595c4401829e471f48b83236d895e378'
  })

  depends_on 'glibc' # R
end

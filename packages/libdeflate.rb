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

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdeflate/1.19_armv7l/libdeflate-1.19-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdeflate/1.19_armv7l/libdeflate-1.19-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdeflate/1.19_i686/libdeflate-1.19-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdeflate/1.19_x86_64/libdeflate-1.19-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9c2808b40e8257439943369bf44153758e706f09446b9b92de42391ebb52dd00',
     armv7l: '9c2808b40e8257439943369bf44153758e706f09446b9b92de42391ebb52dd00',
       i686: '0c5306cc7692ae9f5061a5a89e13da1bb1ece3240366238613301e69003c7236',
     x86_64: 'b339d1e1e71fcf0aed63e4ed3cd52a5b595c4401829e471f48b83236d895e378'
  })

  depends_on 'glibc' # R
end

require 'buildsystems/cmake'

class Libversion < CMake
  description 'Advanced version string comparison library.'
  homepage 'https://github.com/repology/libversion'
  version '3.0.4'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/repology/libversion.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd9b1164fcf89b40bbc6b81b0d935b10a107d8c13f86d58d4e2906ab2d9572c6b',
     armv7l: 'd9b1164fcf89b40bbc6b81b0d935b10a107d8c13f86d58d4e2906ab2d9572c6b',
       i686: '57192007d0a6ac991165247e7dcd9f90ebc82e505caa19436d4c12533c378751',
     x86_64: '0d451b69e43e8931d79e2a097ecce63bf4d287e37ccb67c80839f06a5956c812'
  })

  depends_on 'gcc_lib' => :executable_only
  depends_on 'glibc' # R

  run_tests
end

require 'buildsystems/cmake'

class Superlu < CMake
  description 'SuperLU is a general purpose library for the direct solution of large, sparse, nonsymmetric systems of linear equations.'
  homepage 'https://portal.nersc.gov/project/sparse/superlu/'
  version '7.0.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/xiaoyeli/superlu.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '56e1e4db063c6759ef887d8520aeb666be6ae702e08eb65cebf881a184e5beb7',
     armv7l: '56e1e4db063c6759ef887d8520aeb666be6ae702e08eb65cebf881a184e5beb7',
       i686: '6862f5bd1439411218aa95eacd25d0903ff37bc008368a6856383b0719ae0675',
     x86_64: '2eb0fcfcf25f97e81d24fa1a724f60bd7443e3dd86bfcc6606177fbaac6048fa'
  })

  run_tests
end

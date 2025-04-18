require 'buildsystems/cmake'

class Agedu < CMake
  description 'Unix utility for tracking down wasted disk space'
  homepage 'https://www.chiark.greenend.org.uk/~sgtatham/agedu/'
  version '20241013'
  license 'Copyright 2008 Simon Tatham. All rights reserved.'
  compatibility 'all'
  source_url 'https://www.chiark.greenend.org.uk/~sgtatham/agedu/agedu-20241013.3622eda.tar.gz'
  source_sha256 '3f77cb2e4dd64c100f7a7b0789a6c06cc16f23e7fe78c1451f5020dd823cf2f8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ca67a3afee10201611b013ac9e2c149afcf654809e2273a9f155c530867a6ffd',
     armv7l: 'ca67a3afee10201611b013ac9e2c149afcf654809e2273a9f155c530867a6ffd',
       i686: 'c153c07d345c234b1b2cb80fef13e0ba7795a617e51668a84c5e02ac0e8afe13',
     x86_64: 'f7fae33f4232330696a95452a86f2f99b9ea10ba2688589d4e0d895610a4ae85'
  })

  depends_on 'glibc' # R
end

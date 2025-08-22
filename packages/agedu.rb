require 'buildsystems/cmake'

class Agedu < CMake
  description 'Unix utility for tracking down wasted disk space'
  homepage 'https://www.chiark.greenend.org.uk/~sgtatham/agedu/'
  version '20241013.3622eda'
  license 'Copyright 2008 Simon Tatham. All rights reserved.'
  compatibility 'all'
  source_url "https://www.chiark.greenend.org.uk/~sgtatham/agedu/agedu-#{version}.tar.gz"
  source_sha256 '3f77cb2e4dd64c100f7a7b0789a6c06cc16f23e7fe78c1451f5020dd823cf2f8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '44559363e302ae40f141674da6d01f7262b14b2dc867ea2cf15f72323faeb1e7',
     armv7l: '44559363e302ae40f141674da6d01f7262b14b2dc867ea2cf15f72323faeb1e7',
       i686: '8be416e1b0168df16b13bdb005ab89ba1d4f32cf6e0c466c5123556e71e2c6d2',
     x86_64: '4d85796caa466664eaa35b40d1fae9e546e81ab63faff3b68f648a6f622a8397'
  })

  depends_on 'glibc' # R
end

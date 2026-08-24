require 'buildsystems/cmake'

class Utfcpp < CMake
  description 'UTF-8 with C++ in a Portable Way'
  homepage 'https://github.com/nemtrif/utfcpp'
  version '4.2.0'
  license 'BSL-1.0'
  compatibility 'all'
  source_url 'https://github.com/nemtrif/utfcpp.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2f41bcef3a5a661a24814655526f244ea029e8f7750163eaeb094ea38813850d',
     armv7l: '2f41bcef3a5a661a24814655526f244ea029e8f7750163eaeb094ea38813850d',
       i686: 'fc1c5a0fbcf3fa44f6b0353dcd7a67b0e956727547e3c2de4bf4db1853c9fe99',
     x86_64: '1e38eb656ba1763ac00c9b6dde09ef108cddb26fe88754d8a355b6a94c2f7fe5'
  })
end

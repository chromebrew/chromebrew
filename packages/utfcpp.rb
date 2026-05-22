require 'buildsystems/cmake'

class Utfcpp < CMake
  description 'UTF-8 with C++ in a Portable Way'
  homepage 'https://github.com/nemtrif/utfcpp'
  version '4.1.1'
  license 'BSL-1.0'
  compatibility 'all'
  source_url 'https://github.com/nemtrif/utfcpp.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cb83733bcb0a5f4768306cbc3b5f9322feecb71e93fbc1a583d6730ca56533c1',
     armv7l: 'cb83733bcb0a5f4768306cbc3b5f9322feecb71e93fbc1a583d6730ca56533c1',
       i686: '2cdfa2f71b4e3f2b8faad8b742225bec0dbd588b90c64af250fca90699a965ff',
     x86_64: '85b681cdf5400455ed2c6d6ccd8475cc7d508eccd20ff1010401acfa8b8db83e'
  })
end

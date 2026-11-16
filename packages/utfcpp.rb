require 'buildsystems/cmake'

class Utfcpp < CMake
  description 'UTF-8 with C++ in a Portable Way'
  homepage 'https://github.com/nemtrif/utfcpp'
  version '5.0.0'
  license 'BSL-1.0'
  compatibility 'all'
  source_url 'https://github.com/nemtrif/utfcpp.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd82fa032eea81c5309a5b1ad97029a026a36b5b589e138c224f3583783b10900',
     armv7l: 'd82fa032eea81c5309a5b1ad97029a026a36b5b589e138c224f3583783b10900',
       i686: '2664ae254dd1adc66e23cdf1346f1c475e1b67c19eb9f5eb9e528f5f21bcec8e',
     x86_64: 'cc917ffe8637f2cddf7487ba7bbd5ce075330be97e4b21ba7b002b4c8cbd6f21'
  })
end

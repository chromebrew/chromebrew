require 'buildsystems/cmake'

class Extra_cmake_modules < CMake
  description 'Extra modules and scripts for CMake.'
  homepage 'https://invent.kde.org/frameworks/extra-cmake-modules'
  version '6.21.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://invent.kde.org/frameworks/extra-cmake-modules.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8483579341c800021b404fad4e343bdac2f4cf728814672f851cc70900bc6a7a',
     armv7l: '8483579341c800021b404fad4e343bdac2f4cf728814672f851cc70900bc6a7a',
       i686: '5ff099be77f7a5751a521b1d9b769d6dc9b77119767f9e82603795602cc1fe78',
     x86_64: 'f2e2b5024173d3f3f7f09b2dc59834c79ffebfe8f4b824e7eed9aa08e33cd24a'
  })

  depends_on 'sphinx' => :build
end

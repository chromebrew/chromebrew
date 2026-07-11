require 'buildsystems/cmake'

class Extra_cmake_modules < CMake
  description 'Extra modules and scripts for CMake.'
  homepage 'https://invent.kde.org/frameworks/extra-cmake-modules'
  version '6.28.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://invent.kde.org/frameworks/extra-cmake-modules.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd934bb63cac49a09bc8ccb5a2a85df09c37ef35a5b16978772554b044810b5cc',
     armv7l: 'd934bb63cac49a09bc8ccb5a2a85df09c37ef35a5b16978772554b044810b5cc',
       i686: 'db06682d899d9adcbb7863f271c95ed8a7af38f44815cfa28adc6565ae08b895',
     x86_64: '0c90722b8d628005830c8a574fd822cfea802ece17ce050004e975a14ee48fe9'
  })

  depends_on 'sphinx' => :build
end

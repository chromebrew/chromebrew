require 'buildsystems/cmake'

class Extra_cmake_modules < CMake
  description 'Extra modules and scripts for CMake.'
  homepage 'https://invent.kde.org/frameworks/extra-cmake-modules'
  version '6.23.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://invent.kde.org/frameworks/extra-cmake-modules.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8c40019a0b6a15958974cb640f12a21a29d2c279d3f41c785e55dc46456ca226',
     armv7l: '8c40019a0b6a15958974cb640f12a21a29d2c279d3f41c785e55dc46456ca226',
       i686: '43da0139e328595664cc5e43eb54f8e596284b6091a444556ed45d012ac1181e',
     x86_64: 'c4ccf5b7e985a2cf8838288ef27cd73e6647cf4d4c6ad6157160b5668069f644'
  })

  depends_on 'sphinx' => :build
end

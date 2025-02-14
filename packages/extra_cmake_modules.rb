require 'buildsystems/cmake'

class Extra_cmake_modules < CMake
  description 'Extra modules and scripts for CMake.'
  homepage 'https://invent.kde.org/frameworks/extra-cmake-modules'
  version '6.11.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://invent.kde.org/frameworks/extra-cmake-modules.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ea4855c212a9aec1c5c8fc9814b9e06c1ee6e78c9469311477ee624b1f328b16',
     armv7l: 'ea4855c212a9aec1c5c8fc9814b9e06c1ee6e78c9469311477ee624b1f328b16',
       i686: 'dd678b6ba3eac98d94f3eeaccc9bb567eece03e70ecd9088969acd1097d82c6f',
     x86_64: 'c6b4de42093bdfcd9bd04cc291d3fca80d287d0132791c57c1c5f71fcc8a45d0'
  })
end

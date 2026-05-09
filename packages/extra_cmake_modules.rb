require 'buildsystems/cmake'

class Extra_cmake_modules < CMake
  description 'Extra modules and scripts for CMake.'
  homepage 'https://invent.kde.org/frameworks/extra-cmake-modules'
  version '6.26.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://invent.kde.org/frameworks/extra-cmake-modules.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '632e95a9080c0b135cf0db5fa385484b4211b86170047e37f641e340d87f4af3',
     armv7l: '632e95a9080c0b135cf0db5fa385484b4211b86170047e37f641e340d87f4af3',
       i686: 'afd7137558c1dbf7b8713af3d24bd372e650757fa29488476368db5b44a5b731',
     x86_64: 'b285b8e0485566638f18b8a263304292156a1c1a710b239ce5702dc16989b681'
  })

  depends_on 'sphinx' => :build
end

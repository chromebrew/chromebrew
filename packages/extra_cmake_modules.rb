require 'buildsystems/cmake'

class Extra_cmake_modules < CMake
  description 'Extra modules and scripts for CMake.'
  homepage 'https://invent.kde.org/frameworks/extra-cmake-modules'
  version '6.25.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://invent.kde.org/frameworks/extra-cmake-modules.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '66830a84c55e9ae324c73d023c751a9ab7f59ce8c8c70338fc4206e3fa4669d4',
     armv7l: '66830a84c55e9ae324c73d023c751a9ab7f59ce8c8c70338fc4206e3fa4669d4',
       i686: '0964ac24653f46018efac97bac894ee26dc6a0b40734430569a1915fdbdc48c0',
     x86_64: 'a482923e2c3fb0045a71d3a8551423bd5fa5ef2237098e4f2e5210f6fe30ae3e'
  })

  depends_on 'sphinx' => :build
end

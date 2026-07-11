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
    aarch64: '1b4cb06a34a6fbf1277e4dd87c27229b488202b75430f99892bb567a73db85b7',
     armv7l: '1b4cb06a34a6fbf1277e4dd87c27229b488202b75430f99892bb567a73db85b7',
       i686: '3b100276dba439df714dc6935395bb266269b8108ef6fb63f4823bcd8176b70c',
     x86_64: 'bdab332726692234019c316857e1e9cc48a105e011fe3969b690fe796b05fd11'
  })

  depends_on 'sphinx' => :build
end

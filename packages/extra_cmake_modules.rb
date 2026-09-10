require 'buildsystems/cmake'

class Extra_cmake_modules < CMake
  description 'Extra modules and scripts for CMake.'
  homepage 'https://invent.kde.org/frameworks/extra-cmake-modules'
  version '6.30.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://invent.kde.org/frameworks/extra-cmake-modules.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e051ea7e54f97dc0be815bf2434ae163cbded54a56bd2bb8a426e0a2c54d4ab8',
     armv7l: 'e051ea7e54f97dc0be815bf2434ae163cbded54a56bd2bb8a426e0a2c54d4ab8',
       i686: 'a497639b0ad8c252e3caa2e9578a1e1dbbc810be13e4237f193f804c6237fc0f',
     x86_64: '061a103c316a7fb097ed6bfcbbc5610f51e45fa6c9e779dfd84b7505baff8432'
  })

  depends_on 'sphinx' => :build
end

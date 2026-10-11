require 'buildsystems/cmake'

class Extra_cmake_modules < CMake
  description 'Extra modules and scripts for CMake.'
  homepage 'https://invent.kde.org/frameworks/extra-cmake-modules'
  version '6.31.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://invent.kde.org/frameworks/extra-cmake-modules.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a778e06c90ccaf3e96c3047782b5500145bc75afb0e5c2ef3b3d5d1ed37a272b',
     armv7l: 'a778e06c90ccaf3e96c3047782b5500145bc75afb0e5c2ef3b3d5d1ed37a272b',
       i686: '5698659874cc832468f40d2d6e0c68235bfa42e759f9c9075dbe98a40281b268',
     x86_64: '990e8300ce878588ce9c2f93a82fc0045308597cf7b222d23bf95ce175eab5b4'
  })

  depends_on 'sphinx' => :build
end

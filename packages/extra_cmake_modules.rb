require 'buildsystems/cmake'

class Extra_cmake_modules < CMake
  description 'Extra modules and scripts for CMake.'
  homepage 'https://invent.kde.org/frameworks/extra-cmake-modules'
  version '6.24.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://invent.kde.org/frameworks/extra-cmake-modules.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b0b612da961729b0c5607166309ac68b5c7b682dfdf1f64cd95e14f4273b0529',
     armv7l: 'b0b612da961729b0c5607166309ac68b5c7b682dfdf1f64cd95e14f4273b0529',
       i686: 'fe9e4c3ac9d7bd5e7e4b07895bddaf3b6c1006c8b571184342911d1dccd589a8',
     x86_64: '0581df9523578261998ce21c48da694c4410ca08c0b43e6c1ede2c04759fe315'
  })

  depends_on 'sphinx' => :build
end

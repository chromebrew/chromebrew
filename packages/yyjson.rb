require 'buildsystems/cmake'

class Yyjson < CMake
  description 'A high performance JSON library written in ANSI C'
  homepage 'https://ibireme.github.io/yyjson'
  version '0.12.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ibireme/yyjson.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '26423264b2d7c2414a53b99db68415d6c4d911e14282ad33edf7c599e57676c0',
     armv7l: '26423264b2d7c2414a53b99db68415d6c4d911e14282ad33edf7c599e57676c0',
       i686: 'c43dfb2091d143cc43ddd78c353077f94b40d91fb62ee9eb3a535035468b57a8',
     x86_64: 'f9ab48ee53291f51446a0a6238ae8263e6d7653a101c6b46f51354039f334b98'
  })

  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end

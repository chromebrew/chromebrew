require 'buildsystems/cmake'

class Glm < CMake
  description 'OpenGL Mathematics (GLM) is a header only C++ mathematics library for graphics software based on the OpenGL Shading Language (GLSL) specifications.'
  homepage 'https://github.com/g-truc/glm'
  version '1.0.2'
  license 'HappyBunny or MIT'
  compatibility 'all'
  source_url 'https://github.com/g-truc/glm.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8bfda3558ff29463850cb1cca03f14a61ea17e6f2eeb4e749802042e491d1627',
     armv7l: '8bfda3558ff29463850cb1cca03f14a61ea17e6f2eeb4e749802042e491d1627',
       i686: '51470c156f3de430a95762c990f589d966af0e2a62b26b3933cb09aea9849b82',
     x86_64: '720e0e265acc7e8851df0dbee71253fd447502970f8d60336c5273d955f979d1'
  })
end

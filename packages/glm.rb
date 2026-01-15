require 'buildsystems/cmake'

class Glm < CMake
  description 'OpenGL Mathematics (GLM) is a header only C++ mathematics library for graphics software based on the OpenGL Shading Language (GLSL) specifications.'
  homepage 'https://github.com/g-truc/glm'
  version '1.0.3'
  license 'HappyBunny or MIT'
  compatibility 'all'
  source_url 'https://github.com/g-truc/glm.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '38fd1765a1eb9d57a0ddd003bfe3adb8a7a65d167bee2e982f7a382d592b2f51',
     armv7l: '38fd1765a1eb9d57a0ddd003bfe3adb8a7a65d167bee2e982f7a382d592b2f51',
       i686: '3c5ccd02f0aed753ceb41ad0f642a278506428fb8fa16b6d588d8fe957b77f28',
     x86_64: '5053aaee4b3648dc9eea87f3d2211d413a9aa09563362b466d91ca301cfa0b23'
  })
end

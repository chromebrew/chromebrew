require 'buildsystems/cmake'

class Glm < CMake
  description 'OpenGL Mathematics (GLM) is a header only C++ mathematics library for graphics software based on the OpenGL Shading Language (GLSL) specifications.'
  homepage 'https://github.com/g-truc/glm'
  version '1.0.1'
  license 'HappyBunny or MIT'
  compatibility 'all'
  source_url 'https://github.com/g-truc/glm.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a42840de189b09fdb95a90bd9c79e8f328ad54066c8938b97fec212bd6b85f90',
     armv7l: 'a42840de189b09fdb95a90bd9c79e8f328ad54066c8938b97fec212bd6b85f90',
       i686: '58b1140caf7a0a6b0e5c5d92d328214d3bfdcaabf8274289541ced0780564dfa',
     x86_64: 'f275be06cde1f1a48e5d91cb60fae0c61d868f5b41c87e89853d0e7fd20fc7cc'
  })
end

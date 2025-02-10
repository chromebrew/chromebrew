require 'buildsystems/cmake'

class Freeglut < CMake
  description 'FreeGLUT is a free and open-source alternative to the OpenGL Utility Toolkit (GLUT) library.'
  homepage 'https://freeglut.sourceforge.net/'
  version '3.6.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/freeglut/freeglut.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7326dbfdaad596eb354a0b94d1007e688fb91e17b168931fcc8f68545da0d0f5',
     armv7l: '7326dbfdaad596eb354a0b94d1007e688fb91e17b168931fcc8f68545da0d0f5',
     x86_64: 'ba04cdbe7992fb0253178ed0cae5a1ddf39a05800c78e8ae42b41e7b7f8d7173'
  })

  depends_on 'libglu'
end

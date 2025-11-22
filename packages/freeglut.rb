require 'buildsystems/cmake'

class Freeglut < CMake
  description 'FreeGLUT is a free and open-source alternative to the OpenGL Utility Toolkit (GLUT) library.'
  homepage 'https://freeglut.sourceforge.net/'
  version '3.8.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/freeglut/freeglut.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8bf8dbed8391095e6c866852a596a6a5c49e456cba7805bbc9d834fee4d03968',
     armv7l: '8bf8dbed8391095e6c866852a596a6a5c49e456cba7805bbc9d834fee4d03968',
     x86_64: 'd6583d548829e3ff1fff0c2105bf96c9868f4845ccff81949d9e85a616988182'
  })

  depends_on 'glibc' # R
  depends_on 'libglu'
  depends_on 'libglvnd' # R
  depends_on 'libx11' # R
end

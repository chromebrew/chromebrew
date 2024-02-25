require 'buildsystems/cmake'

class Xzutils < CMake
  description 'XZ Utils is free general-purpose data compression software with a high compression ratio.'
  homepage 'http://tukaani.org/xz/'
  version '5.6.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/tukaani-project/xz/releases/download/v5.6.0/xz-5.6.0.tar.xz'
  source_sha256 'cdafe1632f139c82937cc1ed824f7a60b7b0a0619dfbbd681dcac02b1ac28f5b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '91369bd0f0fca21a32f25e3105bac709ab7078392c58901e7fce79589b5bff53',
     armv7l: '91369bd0f0fca21a32f25e3105bac709ab7078392c58901e7fce79589b5bff53',
       i686: 'b995844c097b8e9b829717a9eb83ec1a4297cee253e3ac7555ff11626ad7abee',
     x86_64: 'b0a0a69fd76ff9c1f9369e156b2fcb41118e6b820f5bf2a0381c7db7d9db0a13'
  })

  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON \
                 -DENABLE_SANDBOX=OFF'
end

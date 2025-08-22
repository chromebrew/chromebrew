# Adapted from Arch Linux opusfile PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/opusfile/trunk/PKGBUILD

require 'buildsystems/cmake'

class Opusfile < CMake
  description 'Library for opening, seeking, and decoding .opus files'
  homepage 'https://opus-codec.org/'
  version '0.12-8890ea3'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/xiph/opusfile.git'
  git_hashtag '8890ea3e96cbeb813c8660bfb4222bad10009c60'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '811438b5811763a3093d8c41767feec1b8148ebe50a1b523b6d46cbdd39a7be9',
     armv7l: '811438b5811763a3093d8c41767feec1b8148ebe50a1b523b6d46cbdd39a7be9',
       i686: '67852e45776331a0a5a84a3593c32502e0f9cc6b712e411f27806e39bb11c631',
     x86_64: '12943bbc15dea36eda29053b1b9e3687df975ccab64ca25e59200ac19a8f0654'
  })

  depends_on 'glibc' # R
  depends_on 'libogg' # R
  depends_on 'openssl' # R
  depends_on 'opus' # R

  git_fetchtags

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end

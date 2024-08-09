# Adapted from Arch Linux uriparser PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/uriparser/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Uriparser < CMake
  description 'uriparser is a strictly RFC 3986 compliant URI parsing library. uriparser is cross-platform, fast, supports Unicode'
  homepage 'https://github.com/uriparser/uriparser'
  version '0.9.8'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/uriparser/uriparser.git'
  git_hashtag "uriparser-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '77d22fae268c12a31a2eba2c037cb3718f1dfb004e9531a8c9ad879b68490080',
     armv7l: '77d22fae268c12a31a2eba2c037cb3718f1dfb004e9531a8c9ad879b68490080',
       i686: 'ee7edb28aad6c6e8882cf4c1a06de299e339daca3c55ebab879103a1ace6204d',
     x86_64: 'e2771905c7ee1a98801a6b0c970800a86c04cc1a931643b861cf267c06a62a1c'
  })

  depends_on 'glibc' # R

  cmake_options '-DURIPARSER_BUILD_DOCS=OFF \
    -DURIPARSER_BUILD_TESTS=OFF'
end

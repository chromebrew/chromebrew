# Adapted from Arch Linux uriparser PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/uriparser/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Uriparser < CMake
  description 'uriparser is a strictly RFC 3986 compliant URI parsing library. uriparser is cross-platform, fast, supports Unicode'
  homepage 'https://github.com/uriparser/uriparser'
  version '0.9.8'
  license 'custom'
  compatibility 'all'
  source_url 'https://github.com/uriparser/uriparser.git'
  git_hashtag "uriparser-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8053c28c9944acbe7ff867f50c13a1b6411cf4c16a2e3cf236cdea8515076b21',
     armv7l: '8053c28c9944acbe7ff867f50c13a1b6411cf4c16a2e3cf236cdea8515076b21',
       i686: '9c11d9d2255fd8c430ddb15fa303f016c0968e1744831d259712d62035f13314',
     x86_64: 'f0d7c6dafc7530d0e447f4b3cae715c1d82988ef7eb5745614b5ead57e21e648'
  })

  cmake_options '-DURIPARSER_BUILD_DOCS=OFF \
    -DURIPARSER_BUILD_TESTS=OFF'
end

# Adapted from Arch Linux uriparser PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/uriparser/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Uriparser < CMake
  description 'uriparser is a strictly RFC 3986 compliant URI parsing library. uriparser is cross-platform, fast, supports Unicode'
  homepage 'https://github.com/uriparser/uriparser'
  version '1.0.0'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/uriparser/uriparser.git'
  git_hashtag "uriparser-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c5e487a16d9f039f16ef94210342a6dfadd24e4c91775ce5207718890cb7127',
     armv7l: '0c5e487a16d9f039f16ef94210342a6dfadd24e4c91775ce5207718890cb7127',
       i686: '00899aeb7218e127443df16e1a9c0dabbc96cfcb2a495a62a2e1109a2d8baaad',
     x86_64: '6d588afa003c86a827127f1e62761775bebf361a83247726bad57df3d839e543'
  })

  depends_on 'glibc' => :library

  cmake_options '-DURIPARSER_BUILD_DOCS=OFF \
    -DURIPARSER_BUILD_TESTS=OFF'
end

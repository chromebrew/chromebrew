# Adapted from Arch Linux libnghttp3 PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/libnghttp3/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Libnghttp3 < CMake
  description 'HTTP/3 library written in C'
  homepage 'https://github.com/ngtcp2/nghttp3'
  version '1.12.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ngtcp2/nghttp3.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a45307644e5bdf95818bccc4264333f6b02d7840addff4286c489d2f1e1bd943',
     armv7l: 'a45307644e5bdf95818bccc4264333f6b02d7840addff4286c489d2f1e1bd943',
       i686: '627619711e5c0c46f05a6ccb7695e9079c303b5ceb4af83aa97c7faae420a2d8',
     x86_64: '2a7fa31e59d2c1e465b591f37f266ffcd6ff148bb5cf85b60c6bc98e85a6c491'
  })

  depends_on 'glibc' # R

  cmake_options '-DENABLE_LIB_ONLY=ON'
end

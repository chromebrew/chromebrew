# Adapted from Arch Linux protobuf PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/protobuf/trunk/PKGBUILD

require 'buildsystems/cmake'

class Protobuf < CMake
  description 'Protocol Buffers - Googles data interchange format'
  homepage 'https://protobuf.dev'
  version '33.5'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/protocolbuffers/protobuf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2de9f29509b12c2cc71860c8bfb9d5a9cc54da561c3a65e239cb47454612f143',
     armv7l: '2de9f29509b12c2cc71860c8bfb9d5a9cc54da561c3a65e239cb47454612f143',
       i686: '00510f8b61c1ae0998c5b655adc915a641a0578fb3cbe09f8765bffb6135438b',
     x86_64: 'ace36c332949e14ba768997707c614323254e01ca6f1f32650a95d9a3cbab1f3'
  })

  depends_on 'abseil_cpp' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'zlib' # R

  cmake_options '-Dprotobuf_BUILD_SHARED_LIBS=ON \
      -Dprotobuf_BUILD_TESTS=OFF'
end

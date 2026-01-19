# Adapted from Arch Linux protobuf PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/protobuf/trunk/PKGBUILD

require 'buildsystems/cmake'

class Protobuf < CMake
  description 'Protocol Buffers - Googles data interchange format'
  homepage 'https://protobuf.dev'
  version '33.4'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/protocolbuffers/protobuf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bcc2fc07c4f7059edd91e0817ff9cee1a8edebf6034a5b1166eb78321cb4856c',
     armv7l: 'bcc2fc07c4f7059edd91e0817ff9cee1a8edebf6034a5b1166eb78321cb4856c',
       i686: '969a8b35b98f73310a463e729618960f6c4f2b53df6e7fed945211622274858b',
     x86_64: 'e652c83908d62b178bba5d7803ee14d8adc4c3a3cb2abc7794fcfac8d256af30'
  })

  depends_on 'abseil_cpp' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'zlib' # R

  cmake_options '-Dprotobuf_BUILD_SHARED_LIBS=ON \
      -Dprotobuf_BUILD_TESTS=OFF'
end

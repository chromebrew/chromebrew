# Adapted from Arch Linux protobuf PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/protobuf/trunk/PKGBUILD

require 'buildsystems/cmake'

class Protobuf < CMake
  description 'Protocol Buffers - Googles data interchange format'
  homepage 'https://protobuf.dev'
  version '32.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/protocolbuffers/protobuf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '33613d218365885a7b9fd6498b910cd24559261a59338c315811f9d161b0010b',
     armv7l: '33613d218365885a7b9fd6498b910cd24559261a59338c315811f9d161b0010b',
       i686: '6b6e79e0c4e8139a11217692f5c25869a3b0fe0701bea95588ac03fa0ac89802',
     x86_64: 'f25fae277e4005a617fc89f37054d1afc4a1ed5733d5f02657807d3a62b80bf4'
  })

  depends_on 'abseil_cpp' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'zlib' # R

  cmake_options '-Dprotobuf_BUILD_SHARED_LIBS=ON \
      -Dprotobuf_BUILD_TESTS=OFF'
end

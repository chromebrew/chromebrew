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
    aarch64: 'cbc7d02e13db52c785fb399fb7487c3a16d0289aced82e289d3138069d81780a',
     armv7l: 'cbc7d02e13db52c785fb399fb7487c3a16d0289aced82e289d3138069d81780a',
       i686: '87689212f97eb6a01c42d72b3756a3e2e7cc194143be06dba596e190bf785e8c',
     x86_64: '51ef7a143e1b87a545812100ee538aa2875e6e4f03b7f29c3718e5d546ff216e'
  })

  depends_on 'abseil_cpp' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'zlib' # R

  cmake_options '-Dprotobuf_BUILD_SHARED_LIBS=ON \
      -Dprotobuf_BUILD_TESTS=OFF'
end

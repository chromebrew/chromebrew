# Adapted from Arch Linux protobuf PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/protobuf/trunk/PKGBUILD

require 'buildsystems/cmake'

class Protobuf < CMake
  description 'Protocol Buffers - Googles data interchange format'
  homepage 'https://protobuf.dev'
  version '34.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/protocolbuffers/protobuf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6bc9efc69d5f8f6c666e27f27d2b3eca4db3537f13500762312a24999f0eab86',
     armv7l: '6bc9efc69d5f8f6c666e27f27d2b3eca4db3537f13500762312a24999f0eab86',
       i686: '158a666d86b2f0dbb2cac91eb81bc880b3a0958e76bca75b9d2fb0459bf25256',
     x86_64: 'ec736e7b44e1b278b9ce120a28e9c89fd29adbe09a9824fb3bc1aa82a519fd46'
  })

  depends_on 'abseil_cpp' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'zlib' # R

  cmake_options '-Dprotobuf_BUILD_SHARED_LIBS=ON \
      -Dprotobuf_BUILD_TESTS=OFF'
end

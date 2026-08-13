require 'buildsystems/cmake'

class Libde265 < CMake
  description 'Open h.265 video codec implementation.'
  homepage 'https://github.com/strukturag/libde265'
  version '1.1.1'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/strukturag/libde265.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9bb1e498a24b99f25ca2573efa19af0ba0b80fe787b8290f83710b047b4f8b3d',
     armv7l: '9bb1e498a24b99f25ca2573efa19af0ba0b80fe787b8290f83710b047b4f8b3d',
     x86_64: 'ca2cbda88810f15a62f9afe38722544d170cde511b065ed7495481b194ae83aa'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'sdl2' => :build

  cmake_options '-DENABLE_DECODER=ON \
      -DENABLE_ENCODER=ON \
      -DENABLE_SDL=ON'
end

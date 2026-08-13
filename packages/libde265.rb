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
    aarch64: 'bb04167db9d024dacc1e601bbe557cd2fc5f286ec5fa380d2e30b59999c67cd6',
     armv7l: 'bb04167db9d024dacc1e601bbe557cd2fc5f286ec5fa380d2e30b59999c67cd6',
     x86_64: '3328d7d336f5ed0b150d88908b3f7ba256391eb9827f53ed7127693fa2788582'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'sdl2' => :executable
  depends_on 'sdl2_compat' => :executable

  cmake_options '-DENABLE_DECODER=ON \
      -DENABLE_ENCODER=ON \
      -DENABLE_SDL=ON'
end

require 'buildsystems/cmake'

class Libde265 < CMake
  description 'Open h.265 video codec implementation.'
  homepage 'https://github.com/strukturag/libde265'
  version '1.1.3'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/strukturag/libde265.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5d22a473010a4c97827b8038d73eac5855ce43f3e05a6195df663d29b14956a2',
     armv7l: '5d22a473010a4c97827b8038d73eac5855ce43f3e05a6195df663d29b14956a2',
     x86_64: '7b255b996d45925bf71f8fb223833929f3f2080c2dd3e6eed2a83865c80a5578'
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

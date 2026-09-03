require 'buildsystems/cmake'

class Libde265 < CMake
  description 'Open h.265 video codec implementation.'
  homepage 'https://github.com/strukturag/libde265'
  version '1.1.2'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/strukturag/libde265.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6159c9e0c16be23fe654021ee7735046cccf3f1acde00c035aa6fe9599ee37ce',
     armv7l: '6159c9e0c16be23fe654021ee7735046cccf3f1acde00c035aa6fe9599ee37ce',
     x86_64: '0a68d6c6c14d633c71f03cddc32d03c124e9e6457bbd2962a5c8544967226df8'
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

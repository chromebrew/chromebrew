require 'buildsystems/cmake'

class Libsdl2 < CMake
  description 'Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D.'
  homepage 'http://www.libsdl.org'
  version '2.32.2'
  license 'ZLIB'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libsdl-org/SDL.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '710b7fa20c48c03f3a4e2be8e6545831430254baa86d8342efd4f4c24bbceed2',
     armv7l: '710b7fa20c48c03f3a4e2be8e6545831430254baa86d8342efd4f4c24bbceed2',
     x86_64: '45f879c176cde80a2bc87392de74df17b71c026b4bacbddeb7704a90d9f6707f'
  })

  depends_on 'alsa_lib' => :build
  depends_on 'glibc' # R
  depends_on 'ibus' => :build
  depends_on 'libdecor' # R
  depends_on 'nasm' => :build
  depends_on 'pulseaudio' => :build
  depends_on 'xwayland' => :build

  cmake_options ARCH == 'x86_64' ? '-DOPT_DEF_SSEMATH=ON' : ''
end

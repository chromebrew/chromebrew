require 'buildsystems/cmake'

class Libsdl2 < CMake
  description 'Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D.'
  homepage 'http://www.libsdl.org'
  version '2.30.0'
  license 'ZLIB'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/libsdl-org/SDL.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2ac3f854f9154c52c336f1437e867288d5e1861b93109393eaa90117255b186d',
     armv7l: '2ac3f854f9154c52c336f1437e867288d5e1861b93109393eaa90117255b186d',
     x86_64: '781d572fd31457fc6c92d57a73dc33a071e9a9df4e1ee78e6dc9496f21155410'
  })

  depends_on 'alsa_lib' => :build
  depends_on 'glibc' # R
  depends_on 'ibus' => :build
  depends_on 'libdecor' # R
  depends_on 'nasm' => :build
  depends_on 'pulseaudio' => :build
  depends_on 'xwayland' => :build

  @cmake_options = ARCH == 'x86_64' ? '-DOPT_DEF_SSEMATH=ON' : ''
end

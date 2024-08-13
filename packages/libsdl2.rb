require 'buildsystems/cmake'

class Libsdl2 < CMake
  description 'Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D.'
  homepage 'http://www.libsdl.org'
  version '2.30.6'
  license 'ZLIB'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/libsdl-org/SDL.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6c5228f8a857c3bb44b1f320c6c9900a7597776c14c2a1d4d3f6dd982f0ebc85',
     armv7l: '6c5228f8a857c3bb44b1f320c6c9900a7597776c14c2a1d4d3f6dd982f0ebc85',
     x86_64: '36a1d2e6085589831566dbf9c23bb0125ae87e3c321084f3c8eb0a032d661106'
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

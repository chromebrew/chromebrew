require 'buildsystems/cmake'

class Sdl2 < CMake
  description 'Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D.'
  homepage 'http://www.libsdl.org'
  version '2.32.10'
  license 'ZLIB'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libsdl-org/SDL.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8db3cf0eb16dff6056cc5c9ac575e7c08b8e9a59fe62aa0da3c9d9a9bc44ea60',
     armv7l: '8db3cf0eb16dff6056cc5c9ac575e7c08b8e9a59fe62aa0da3c9d9a9bc44ea60',
     x86_64: '2f205d368c1355e2290a9ccd1eae22a0480e33def5c8e2b15b394e5be737f5f2'
  })

  depends_on 'alsa_lib' => :build
  depends_on 'glibc' # R
  depends_on 'ibus' => :build
  depends_on 'nasm' => :build
  depends_on 'pulseaudio' => :build
  depends_on 'xwayland' => :build

  cmake_options ARCH == 'x86_64' ? '-DOPT_DEF_SSEMATH=ON' : ''
end

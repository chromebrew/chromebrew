# Adapted from Arch Linux sdl3 PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=sdl3

require 'buildsystems/cmake'

class Sdl3 < CMake
  description 'A library for portable low-level access to a video framebuffer, audio output, mouse, and keyboard Version 3'
  homepage 'https://www.libsdl.org'
  version '3.3.2'
  license 'zlib'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libsdl-org/SDL.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9ba3397585bce1710487317a22886b429263657ba9e1c461739d49e23c8d406c',
     armv7l: '9ba3397585bce1710487317a22886b429263657ba9e1c461739d49e23c8d406c',
     x86_64: 'fdfa184af02e96e717aa1341d5fb3799bc126e3917cce9a5734183a6c282f783'
  })

  depends_on 'alsa_lib' => :build
  depends_on 'glibc' # R
  depends_on 'libusb' => :build
  depends_on 'libx11' => :build
  depends_on 'libxcursor' => :build
  depends_on 'libxext' => :build
  depends_on 'libxinerama' => :build
  depends_on 'libxkbcommon' => :build
  depends_on 'libxrandr' => :build
  depends_on 'libxrender' => :build
  depends_on 'mesa' => :build
  depends_on 'pulseaudio' => :build
  depends_on 'wayland' => :build

  cmake_options '-DSDL_HIDAPI_LIBUSB=OFF \
    -DSDL_RPI=OFF \
    -DSDL_STATIC=OFF \
    -DSDL_RPATH=OFF'
end

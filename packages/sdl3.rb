# Adapted from Arch Linux sdl3 PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=sdl3

require 'buildsystems/cmake'

class Sdl3 < CMake
  description 'A library for portable low-level access to a video framebuffer, audio output, mouse, and keyboard Version 3'
  homepage 'https://www.libsdl.org'
  version '3.2.0'
  license 'zlib'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/libsdl-org/SDL.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e0195301acfa082d4c5f0e6a10a4d3a61fca0255309bdce5ae4490cbbf2a90fc',
     armv7l: 'e0195301acfa082d4c5f0e6a10a4d3a61fca0255309bdce5ae4490cbbf2a90fc',
     x86_64: 'e1ae3a011af30355113c47f0c5ab458f982aecad2ea6aac67b80fce76364873b'
  })

  depends_on 'libxext' => :build
  depends_on 'libxrender' => :build
  depends_on 'libx11' => :build
  depends_on 'libxcursor' => :build
  depends_on 'libusb' => :build
  depends_on 'alsa_lib' => :build
  depends_on 'mesa' => :build
  depends_on 'pulseaudio' => :build
  depends_on 'libxrandr' => :build
  depends_on 'libxinerama' => :build
  depends_on 'wayland' => :build
  depends_on 'libxkbcommon' => :build
  depends_on 'glibc' # R

  cmake_options '-DSDL_HIDAPI_LIBUSB=OFF \
    -DSDL_RPI=OFF \
    -DSDL_STATIC=OFF \
    -DSDL_RPATH=OFF'
end

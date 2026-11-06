# Adapted from Arch Linux sdl3 PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=sdl3

require 'buildsystems/cmake'

class Sdl3 < CMake
  description 'A library for portable low-level access to a video framebuffer, audio output, mouse, and keyboard Version 3'
  homepage 'https://www.libsdl.org'
  version '3.4.20'
  license 'zlib'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libsdl-org/SDL.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ed2842542ba68df02abdc31569045e7d311b8670ce6dd9dc2ffe57c3e8ab6752',
     armv7l: 'ed2842542ba68df02abdc31569045e7d311b8670ce6dd9dc2ffe57c3e8ab6752',
     x86_64: 'c778d2d2c6bd78653bc73d680f8ac6e3cfb6536722f6b7eea8115687086a8136'
  })

  depends_on 'alsa_lib' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
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
    -DSDL_X11_XSCRNSAVER=OFF \
    -DSDL_STATIC=OFF \
    -DSDL_RPATH=OFF'
end

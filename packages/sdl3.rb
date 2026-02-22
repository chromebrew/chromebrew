# Adapted from Arch Linux sdl3 PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=sdl3

require 'buildsystems/cmake'

class Sdl3 < CMake
  description 'A library for portable low-level access to a video framebuffer, audio output, mouse, and keyboard Version 3'
  homepage 'https://www.libsdl.org'
  version '3.4.2'
  license 'zlib'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libsdl-org/SDL.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '78585fda4af1898133b94e6111b3af4c93513301a3c82a3b02e2e1ab813ac276',
     armv7l: '78585fda4af1898133b94e6111b3af4c93513301a3c82a3b02e2e1ab813ac276',
     x86_64: '22025ac126f46b20948f333ee971f3ed64114bcb5af4486c1ac7b1782ee28e3e'
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
    -DSDL_X11_XSCRNSAVER=OFF \
    -DSDL_STATIC=OFF \
    -DSDL_RPATH=OFF'
end

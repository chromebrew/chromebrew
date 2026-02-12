# Adapted from Arch Linux sdl3 PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=sdl3

require 'buildsystems/cmake'

class Sdl3 < CMake
  description 'A library for portable low-level access to a video framebuffer, audio output, mouse, and keyboard Version 3'
  homepage 'https://www.libsdl.org'
  version '3.4.0'
  license 'zlib'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libsdl-org/SDL.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9bd18e01507bb4a973cef635bf8d3d380e5f8e1d68a066a936a360ceb4be2017',
     armv7l: '9bd18e01507bb4a973cef635bf8d3d380e5f8e1d68a066a936a360ceb4be2017',
     x86_64: '2b1a42bd80d14f588154d319c17d69cfa2c8643e1d8683c8d222f0e40a787450'
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

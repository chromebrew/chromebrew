require 'buildsystems/cmake'

class Kf5_guiaddons < CMake
  description 'Utilities for graphical user interfaces in the areas of colors, fonts, text, images, keyboard input.'
  homepage 'https://invent.kde.org/frameworks/kguiaddons'
  version '5.116.0'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/frameworks/kguiaddons.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '002a258719b4d71e840b2035ba1ff1be9921829c8b59a6826513e9999fadf39f',
     armv7l: '002a258719b4d71e840b2035ba1ff1be9921829c8b59a6826513e9999fadf39f',
     x86_64: '3c8b00f8f190a0d8c26e2114d9e7b951e093834d9cb66173c85e75c009e9853b'
  })

  depends_on 'extra_cmake_modules'
  depends_on 'plasma_wayland_protocols'
  depends_on 'qt5_base'
  depends_on 'qt5_x11extras'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'qt5_wayland' # R
  depends_on 'wayland' # R

  cmake_options "-DECM_MKSPECS_INSTALL_DIR=#{CREW_PREFIX}/share/qt5/mkspecs/modules"
end

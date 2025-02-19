require 'buildsystems/cmake'

class Kf5_windowsystem < CMake
  description 'KWindowSystem provides information about the windowing system and allows interaction with the windowing system.'
  homepage 'https://invent.kde.org/frameworks/kwindowsystem'
  version '5.116.0'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/frameworks/kwindowsystem.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9b710ac54cd70589a651ebad557f1bec845e038e9c2d37daf72d60e26aeb87dd',
     armv7l: '9b710ac54cd70589a651ebad557f1bec845e038e9c2d37daf72d60e26aeb87dd',
     x86_64: 'd0d907d940aab99b29088cde879409e812c8ebeab04c7b70d34285a035e80fbc'
  })

  depends_on 'extra_cmake_modules'
  depends_on 'qt5_base'
  depends_on 'qt5_tools'
  depends_on 'qt5_x11extras'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libice' # R
  depends_on 'libsm' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'xcb_util_keysyms' # R

  cmake_options "-DECM_MKSPECS_INSTALL_DIR=#{CREW_PREFIX}/share/qt5/mkspecs/modules"
end

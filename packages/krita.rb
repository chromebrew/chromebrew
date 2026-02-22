require 'buildsystems/cmake'

class Krita < CMake
  description 'A generic image manipulation/painting application in the style of Photoshop or GIMP.'
  homepage 'https://krita.org/en/'
  version '5.2.15'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/graphics/krita.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4a9489709d54fec26871c4005e0850832bdb080e5472f85ca29d745ad25572ae',
     armv7l: '4a9489709d54fec26871c4005e0850832bdb080e5472f85ca29d745ad25572ae',
     x86_64: 'c232be80f65828485accf58bfb2a7362348eea7ab02d591b7c72674b7eccb551'
  })

  depends_on 'boost'
  depends_on 'bzip2' # R
  depends_on 'eigen'
  depends_on 'extra_cmake_modules'
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'fribidi' # R
  depends_on 'gcc_lib' # R
  depends_on 'giflib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gsl' # R
  depends_on 'harfbuzz' # R
  depends_on 'immer'
  depends_on 'json_c' # R
  depends_on 'kf5_completion' # R
  depends_on 'kf5_config' # R
  depends_on 'kf5_coreaddons' # R
  depends_on 'kf5_crash'
  depends_on 'kf5_crash' => :executable_only
  depends_on 'kf5_guiaddons' # R
  depends_on 'kf5_i18n' # R
  depends_on 'kf5_itemmodels'
  depends_on 'kf5_itemviews' # R
  depends_on 'kf5_widgetsaddons' # R
  depends_on 'kf5_windowsystem' # R
  depends_on 'lager'
  depends_on 'lcms' # R
  depends_on 'libexiv2' # R
  depends_on 'libheif' # R
  depends_on 'libice' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libjxl' # R
  depends_on 'libmypaint' # R
  depends_on 'libpng' # R
  depends_on 'libsm' # R
  depends_on 'libtiff' # R
  depends_on 'libunibreak' # R
  depends_on 'libwebp' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxi' # R
  depends_on 'mlt' # R
  depends_on 'openexr' # R
  depends_on 'openjpeg' # R
  depends_on 'poppler' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_svg' # R
  depends_on 'qt5_x11extras' # R
  depends_on 'quazip' # R
  depends_on 'sdl2' # R
  depends_on 'zlib' # R
  depends_on 'zug'
end

require 'buildsystems/cmake'

class Krita < CMake
  description 'A generic image manipulation/painting application in the style of Photoshop or GIMP.'
  homepage 'https://krita.org/en/'
  version '5.2.11'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/graphics/krita.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '87ce14943f80db6d8b50faa3c4e033e8b8c2e3df65102ffada983cc34456a2a3',
     armv7l: '87ce14943f80db6d8b50faa3c4e033e8b8c2e3df65102ffada983cc34456a2a3',
     x86_64: '35eea48a87cf37be5d1be89e7ab3d2d1dc5a57d1c65ef4393567566f3359e8c7'
  })

  depends_on 'boost'
  depends_on 'eigen'
  depends_on 'extra_cmake_modules'
  depends_on 'gsl'
  depends_on 'immer'
  depends_on 'kf5_completion'
  depends_on 'kf5_config'
  depends_on 'kf5_coreaddons'
  depends_on 'kf5_crash'
  depends_on 'kf5_guiaddons'
  depends_on 'kf5_i18n'
  depends_on 'kf5_itemmodels'
  depends_on 'kf5_itemviews'
  depends_on 'kf5_widgetsaddons'
  depends_on 'kf5_windowsystem'
  depends_on 'lager'
  depends_on 'libexiv2'
  depends_on 'libmypaint'
  depends_on 'libunibreak'
  depends_on 'mlt'
  depends_on 'openexr'
  depends_on 'qt5_base'
  depends_on 'qt5_svg'
  depends_on 'quazip'
  depends_on 'zug'
  depends_on 'bzip2' # R
  depends_on 'fontconfig' # R
  depends_on 'harfbuzz' # R
  depends_on 'freetype' # R
  depends_on 'fribidi' # R
  depends_on 'gcc_lib' # R
  depends_on 'giflib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'json_c' # R
  depends_on 'lcms' # R
  depends_on 'libheif' # R
  depends_on 'libice' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libjxl' # R
  depends_on 'libpng' # R
  depends_on 'libsdl2' # R
  depends_on 'libsm' # R
  depends_on 'libtiff' # R
  depends_on 'libwebp' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxi' # R
  depends_on 'openjpeg' # R
  depends_on 'poppler' # R
  depends_on 'qt5_x11extras' # R
  depends_on 'zlib' # R
end

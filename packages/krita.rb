require 'buildsystems/cmake'

class Krita < CMake
  description 'A generic image manipulation/painting application in the style of Photoshop or GIMP.'
  homepage 'https://krita.org/en/'
  version '5.2.9'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/graphics/krita.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
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
end

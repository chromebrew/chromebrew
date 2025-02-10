require 'buildsystems/qmake'

class Qt5_webglplugin < Qmake
  description 'Qt WebGL Plugin'
  homepage 'https://www.qt.io/'
  kde_5_15_githash = '0d29f1cd46331caf1b5169eb037d573680454348'
  version "kde-5.15.15-#{kde_5_15_githash[0, 7]}"
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtwebglplugin.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fc88c6ba7b4f54172ce34dea708a418721f65921286ceac7bea3fd0bfa08ca8a',
     armv7l: 'fc88c6ba7b4f54172ce34dea708a418721f65921286ceac7bea3fd0bfa08ca8a',
     x86_64: '9d3ad8b102e9251ece05eb832affd0f31e84ab2db512c265f70d99cbec1c7f95'
  })

  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
  depends_on 'qt5_websockets' # R
  depends_on 'zlib' # R
end

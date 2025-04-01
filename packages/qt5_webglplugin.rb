require 'buildsystems/qmake'

class Qt5_webglplugin < Qmake
  description 'Qt WebGL Plugin'
  homepage 'https://www.qt.io/'
  kde_5_15_githash = '64efc679e520505be352f2b3ad662184ef265503'
  version "kde-5.15.16-#{kde_5_15_githash[0, 7]}"
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtwebglplugin.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0d6d5c3d785fd1040f203890661539ba9fd3b723fc96b06f467cdbfe55cfd60f',
     armv7l: '0d6d5c3d785fd1040f203890661539ba9fd3b723fc96b06f467cdbfe55cfd60f',
     x86_64: 'd64866fa1ff3bc8b646cda791443616828ac13d68898c2684b11f8b098341c22'
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

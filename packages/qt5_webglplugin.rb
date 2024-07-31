require 'buildsystems/qmake'

class Qt5_webglplugin < Qmake
  description 'Qt WebGL Plugin'
  homepage 'https://www.qt.io/'
  version 'kde-5.15.14-3681356'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtwebglplugin.git'
  git_hashtag '3681356904277e055759693551357e7e488d1be9'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '532403093f52af6a53c464e785dc6730ae24f28b9b205e6fd59e6cad10334e12',
     armv7l: '532403093f52af6a53c464e785dc6730ae24f28b9b205e6fd59e6cad10334e12',
     x86_64: '965c20c9d3bc3335a58ffcb7fb7a72affd1b4c04681d6200240a2e175d6afbb7'
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

require 'buildsystems/qmake'

class Qt5_webglplugin < Qmake
  description 'Qt WebGL Plugin'
  homepage 'https://www.qt.io/'
  version '5.15.11-ddcff45'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtwebglplugin.git'
  git_hashtag 'ddcff45e8f2ca9f229017b3ded62327d2fb50af2' # from kde/5.15 branch
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2a67893a4fe472bf40f8bbb4ec36e682c50c1a371d677507e911fa35de59afc6',
     armv7l: '2a67893a4fe472bf40f8bbb4ec36e682c50c1a371d677507e911fa35de59afc6',
     x86_64: 'd2e2af42f3b8e1f2ece5a2ace99b2a9d476add5914d11aef835a3d9408212a2c'
  })

  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'harfbuzz' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
  depends_on 'qt5_websockets' # R
  depends_on 'zlibpkg' # R
end

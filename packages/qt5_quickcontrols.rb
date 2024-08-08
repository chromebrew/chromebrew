require 'buildsystems/qmake'

class Qt5_quickcontrols < Qmake
  description 'Reusable Qt Quick based UI controls to create classic desktop-style user interfaces'
  homepage 'https://www.qt.io'
  version 'kde-5.15.14-9325659'
  license 'GPL3 LGPL3 FDL custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtquickcontrols.git'
  git_hashtag '9325659ec390eda5b160736a926ba58ccb445cce'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c4efb8b7e53cde9a5d565e2a1a00326f05b923a5ebeaa8f027a4fc35e81ac65',
     armv7l: '0c4efb8b7e53cde9a5d565e2a1a00326f05b923a5ebeaa8f027a4fc35e81ac65',
     x86_64: '63043148e2f2042bf96660c2561b214c331f6e12ae06b9e3a35e02826a3da8c9'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
end

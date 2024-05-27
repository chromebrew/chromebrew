require 'buildsystems/qmake'

class Qt5_quickcontrols2 < Qmake
  description 'Qt Quick Controls 2'
  homepage 'https://www.qt.io/'
  version 'kde-5.15.14-69fea34'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtquickcontrols2.git'
  git_hashtag '69fea340f8f4c483a9b2889e4e24a4b1b52ebc87'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eaf721b18581dab09bfedc1dd6b51997494555f5021df4f1ef362b02a118ac06',
     armv7l: 'eaf721b18581dab09bfedc1dd6b51997494555f5021df4f1ef362b02a118ac06',
     x86_64: '5247aaeba888c8f3042ad2c8ecbba8ce3195338361f0b53038103f883634790e'
  })

  depends_on 'qt5_base'
  depends_on 'qt5_declarative'
end

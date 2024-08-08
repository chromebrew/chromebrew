require 'buildsystems/qmake'

class Qt5_webchannel < Qmake
  description 'Provides access to QObject or QML objects from HTML clients for seamless integration of Qt applications with HTML/JavaScript clients'
  homepage 'https://www.qt.io'
  version 'kde-5.15.14-fca8308'
  license 'GPL3 LGPL3 FDL custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtwebchannel.git'
  git_hashtag 'fca83088ef430f96257d2014e77d08bd350259af'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '94e8b8fce0b5aa835de8e86e1d522339b7184bf0786a43c462a29de30fc9efae',
     armv7l: '94e8b8fce0b5aa835de8e86e1d522339b7184bf0786a43c462a29de30fc9efae',
     x86_64: '7ca694844498a96e2c98d4d9f1917d969541e97fc989005ae268347643a110bc'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
end

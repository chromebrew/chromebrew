require 'buildsystems/qmake'

class Qt5_webchannel < Qmake
  description 'Provides access to QObject or QML objects from HTML clients for seamless integration of Qt applications with HTML/JavaScript clients'
  homepage 'https://www.qt.io'
  kde_5_15_githash = 'ad85920e02049bf7ba06366046498e8366a98e8e'
  version "kde-5.15.15-#{kde_5_15_githash[0, 7]}"
  license 'GPL3 LGPL3 FDL custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtwebchannel.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '71405013f93793e23b7f6b5834e7e87548f33fecd82975f4f7a7f88247dc7002',
     armv7l: '71405013f93793e23b7f6b5834e7e87548f33fecd82975f4f7a7f88247dc7002',
     x86_64: '5c725cca9b25be12c10686237d70273bb597bbc77f180e372eefff6fdf694587'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
end

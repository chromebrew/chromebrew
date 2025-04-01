require 'buildsystems/qmake'

class Qt5_quickcontrols < Qmake
  description 'Reusable Qt Quick based UI controls to create classic desktop-style user interfaces'
  homepage 'https://www.qt.io'
  kde_5_15_githash = 'c0edbd157555ae4d87082f7e786787dabb1f9873'
  version "kde-5.15.16-#{kde_5_15_githash[0, 7]}"
  license 'GPL3 LGPL3 FDL custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtquickcontrols.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9aca2e3ca3e3583124de19cd7400ecd6d2e5d1aace2d673241d297ae07024ede',
     armv7l: '9aca2e3ca3e3583124de19cd7400ecd6d2e5d1aace2d673241d297ae07024ede',
     x86_64: 'ffb88b405e2f2b617b1e9a8833fe6265b59ab176bb9e2a5fc05fdce26282fead'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
end

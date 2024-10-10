require 'buildsystems/qmake'

class Qt5_quickcontrols < Qmake
  description 'Reusable Qt Quick based UI controls to create classic desktop-style user interfaces'
  homepage 'https://www.qt.io'
  kde_5_15_githash = 'fe98f874f89abe9b96edadb812cfa9b1488679f0'
  version "kde-5.15.15-#{kde_5_15_githash[0, 7]}"
  license 'GPL3 LGPL3 FDL custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtquickcontrols.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e96a225540b1d2cc0a9c61a7080099fcb4f94ec63b5c844b5da985ce5c802064',
     armv7l: 'e96a225540b1d2cc0a9c61a7080099fcb4f94ec63b5c844b5da985ce5c802064',
     x86_64: '8a7e44d412caae71aca9b91c06fa57715bc7cc92f975042d395e2767bdd04261'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
end

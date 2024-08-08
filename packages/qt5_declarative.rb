require 'buildsystems/qmake'

class Qt5_declarative < Qmake
  description 'Provides QML and Quick declaratives.'
  homepage 'https://www.qt.io/'
  version 'kde-5.15.14-50c8def'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtdeclarative.git'
  git_hashtag '50c8def854806485d66aabcf6918e8b987032e55'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '97c2e0a5341739ea75050b64113294472155ebe26c7c6321459d7ee549e5cc6c',
     armv7l: '97c2e0a5341739ea75050b64113294472155ebe26c7c6321459d7ee549e5cc6c',
     x86_64: 'bd93a7285ae85533465258affc862fbaab030f8db29b4dc1b34846877111fdfd'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
end

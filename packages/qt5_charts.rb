require 'buildsystems/qmake'

class Qt5_charts < Qmake
  description 'Qt Charts'
  homepage 'https://www.qt.io/'
  version '5.15.11-e17308d'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtcharts.git'
  git_hashtag 'e17308d5ce83a8b66aeeaaaf16ce16d4ee6b2826' # from kde/5.15 branch
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '08dc310e3890a0c0f062ba186ef487f4f5248f006ee88545926cd224f7647a11',
     armv7l: '08dc310e3890a0c0f062ba186ef487f4f5248f006ee88545926cd224f7647a11',
     x86_64: '9ca1578fffcdf10553b44f2db28e28f1abc896b2063c79f9d58db0f2fe5c476a'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
end

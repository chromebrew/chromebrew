require 'buildsystems/qmake'

class Qt5_charts < Qmake
  description 'Qt Charts'
  homepage 'https://www.qt.io/'
  version 'kde-5.15.14-7315c48'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtcharts.git'
  git_hashtag '7315c48bcec88014e78165bbda54abfcd557e0af'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6940289061c119e8e93bc34b9daca25054cbc2cb758bcdb889280958b7d1586c',
     armv7l: '6940289061c119e8e93bc34b9daca25054cbc2cb758bcdb889280958b7d1586c',
     x86_64: '81d51f3919121bc65f5db2efec00f24fab0771241ccc4801e4714f9294cb6b45'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
end

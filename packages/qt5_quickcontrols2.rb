require 'buildsystems/qmake'

class Qt5_quickcontrols2 < Qmake
  description 'Qt Quick Controls 2'
  homepage 'https://www.qt.io/'
  kde_5_15_githash = '8f244d09b22ed68b3aefaa8e521c8d68d18cada7'
  version "kde-5.15.16-#{kde_5_15_githash[0, 7]}"
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtquickcontrols2.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     x86_64: '786c84bceb5f2db46e4a60e6d3dc3e8d6c5b2e77e273d862b8f2f54553789e17'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
end

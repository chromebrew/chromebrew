require 'buildsystems/qmake'

class Qt5_charts < Qmake
  description 'Qt Charts'
  homepage 'https://www.qt.io/'
  kde_5_15_githash = '0c97aae7dc242ac0710e09397672ad878761157a'
  version "kde-5.15.15-#{kde_5_15_githash[0, 7]}"
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtcharts.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '11319f0626324269f604cbb3dc71913802d3b7f63dd39b9af4570127e54bcf78',
     armv7l: '11319f0626324269f604cbb3dc71913802d3b7f63dd39b9af4570127e54bcf78',
     x86_64: '8763cc9bba33b8391ee172a1cb73b2c879042adbdc3ac55f8619b0c3f39fcf39'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
end

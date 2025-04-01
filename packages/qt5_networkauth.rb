require 'buildsystems/qmake'

class Qt5_networkauth < Qmake
  description 'Qt Network Authentication'
  homepage 'https://www.qt.io/'
  kde_5_15_githash = '0ca0165f1fd036ab2d8ebee6e253cf4e05124cc9'
  version "kde-5.15.16-#{kde_5_15_githash[0, 7]}"
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtnetworkauth.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '63557b9bbd82b239c27d06ce6ef37e5dc59fea6f5d0b796b78b786985f5a1df1',
     armv7l: '63557b9bbd82b239c27d06ce6ef37e5dc59fea6f5d0b796b78b786985f5a1df1',
     x86_64: 'a6f477762229c044a3e58146f848e2f0b129b977539f115302233a70dea0f222'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'qt5_base' # R
end

require 'buildsystems/qmake'

class Qt5_location < Qmake
  description 'Qt Location and Positioning'
  homepage 'https://www.qt.io/'
  kde_5_15_githash = '6e89db9fcf76fa35c9275123c814e260610d355e'
  version "kde-5.15.16-#{kde_5_15_githash[0, 7]}"
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtlocation.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c561f8c812502dec95e103b994c00171b07a2567172770e25e221e6163ff7301',
     armv7l: 'c561f8c812502dec95e103b994c00171b07a2567172770e25e221e6163ff7301',
     x86_64: '4b587c3efcf75398a4c818d29aa70b8fe9a646cc5df8608b53ef0c67e2f87e34'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
  depends_on 'qt5_serialport' # R
  depends_on 'zlib' # R
end

require 'buildsystems/qmake'

class Qt5_xmlpatterns < Qmake
  description 'Qt XML Patterns'
  homepage 'https://www.qt.io/'
  kde_5_15_githash = '43996a4e543fa22b345c03ba3a1a41b1aba4b454'
  version "kde-5.15.16-#{kde_5_15_githash[0, 7]}"
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtxmlpatterns.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '00a87c299110f035a99d2adf04e51d56f0c1896820b457ee72a047a359512894',
     armv7l: '00a87c299110f035a99d2adf04e51d56f0c1896820b457ee72a047a359512894',
     x86_64: '12ac79f7a263777c3a573f5d62ac34f057016a11492a842664151846638c0dc5'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
end

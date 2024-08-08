require 'buildsystems/qmake'

class Qt5_serialport < Qmake
  description 'Qt Serial Port'
  homepage 'https://www.qt.io/'
  version 'kde-5.15.14-34c19c6'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtserialport.git'
  git_hashtag '34c19c6441cd440dc65b59ae7670eadf099d51f8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3d00882c466b0be4caaf8518107f3d89dd8ef7cd57c37c9462a2f14180a922a8',
     armv7l: '3d00882c466b0be4caaf8518107f3d89dd8ef7cd57c37c9462a2f14180a922a8',
     x86_64: 'b841d5f05caaeacb4cec4d66a678732aa6f743a4519ddb820227e0262ed988e3'
  })

  depends_on 'eudev' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'qt5_base' # R
end

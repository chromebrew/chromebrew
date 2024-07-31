require 'buildsystems/qmake'

class Qt5_networkauth < Qmake
  description 'Qt Network Authentication'
  homepage 'https://www.qt.io/'
  version 'kde-5.15.14-28180f2'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtnetworkauth.git'
  git_hashtag '28180f28c98e329676463e24cef0097cba45bc00'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e66c2abbad289ea5adc39374233279bf4bff5e900736b1f36b3b31e289fe4ef3',
     armv7l: 'e66c2abbad289ea5adc39374233279bf4bff5e900736b1f36b3b31e289fe4ef3',
     x86_64: 'f47387b32f4418c3bc5a9f352823b4216945f7f67a6de3172fc8443a4cacc5c8'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'qt5_base' # R
end

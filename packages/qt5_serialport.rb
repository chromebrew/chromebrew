require 'buildsystems/qmake'

class Qt5_serialport < Qmake
  description 'Qt Serial Port'
  homepage 'https://www.qt.io/'
  kde_5_15_githash = '875adfdf3ca8f1059fdd3c5fd20baaa00694a2e7'
  version "kde-5.15.16-#{kde_5_15_githash[0, 7]}"
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtserialport.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e3dec5e7e0778ae51e203457eb81b8975c83f58ed71ef51b8479c3d309b53528',
     armv7l: 'e3dec5e7e0778ae51e203457eb81b8975c83f58ed71ef51b8479c3d309b53528',
     x86_64: 'caaeb7da00aba903993e4bd3c0a6adc7d91d742fb6b8a4911cfa43eed389d0f8'
  })

  depends_on 'eudev' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'qt5_base' # R
end

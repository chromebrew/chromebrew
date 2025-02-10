require 'buildsystems/qmake'

class Qt5_serialport < Qmake
  description 'Qt Serial Port'
  homepage 'https://www.qt.io/'
  kde_5_15_githash = 'aa2ffdbd7295db9e5814070d1432a0b77c59cfce'
  version "kde-5.15.15-#{kde_5_15_githash[0, 7]}"
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtserialport.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '85cc7f3ce142ada592e3da58f1585a960ae8ca838c4097f891538385a336e85f',
     armv7l: '85cc7f3ce142ada592e3da58f1585a960ae8ca838c4097f891538385a336e85f',
     x86_64: '36d35a7bfc29afb4b8337af1bd1bac42e2b010c2d41855e0ae56db1e91380f47'
  })

  depends_on 'eudev' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'qt5_base' # R
end

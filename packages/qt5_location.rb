require 'buildsystems/qmake'

class Qt5_location < Qmake
  description 'Qt Location and Positioning'
  homepage 'https://www.qt.io/'
  kde_5_15_githash = 'e0a477d04f35495ba6eeda8578d1311dba623270'
  version "kde-5.15.15-#{kde_5_15_githash[0, 7]}"
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtlocation.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd7226e3dd07f0ff22d1d3620b3070de21652d925dfb991bb29afc685d5ef8ac8',
     armv7l: 'd7226e3dd07f0ff22d1d3620b3070de21652d925dfb991bb29afc685d5ef8ac8',
     x86_64: '48a9b9b9a82d920f2a978ba5beed7cfb50cd182e2092bb662e07387dc7c78492'
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

require 'buildsystems/qmake'

class Qt5_charts < Qmake
  description 'Qt Charts'
  homepage 'https://www.qt.io/'
  kde_5_15_githash = '4e4fc559c61d1fc2542add48d2b3c490214e9936'
  version "kde-5.15.16-#{kde_5_15_githash[0, 7]}"
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtcharts.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9b75ac00f00818a5a77ae8892bf01c6497c52c180ae04c79a1af375463ffce2b',
     armv7l: '9b75ac00f00818a5a77ae8892bf01c6497c52c180ae04c79a1af375463ffce2b',
     x86_64: 'da6762300487077d6d49983d864c195248f6d7b7256ae51bf97aa26acbadb458'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
end

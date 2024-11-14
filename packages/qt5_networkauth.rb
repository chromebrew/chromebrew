require 'buildsystems/qmake'

class Qt5_networkauth < Qmake
  description 'Qt Network Authentication'
  homepage 'https://www.qt.io/'
  kde_5_15_githash = '17d6ed940cea4ead62f4055184d4fc69bf06b789'
  version "kde-5.15.15-#{kde_5_15_githash[0, 7]}"
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtnetworkauth.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1ec3709c7cbb667917c8184d3eb48a7c33291e47ef3d8eadebd86a9faa0030e3',
     armv7l: '1ec3709c7cbb667917c8184d3eb48a7c33291e47ef3d8eadebd86a9faa0030e3',
     x86_64: 'cced625962e25e6f1c9e885bd193a3809e9d442702d242a79cd2636cbcc8742a'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'qt5_base' # R
end

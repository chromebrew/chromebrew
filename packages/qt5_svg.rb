require 'buildsystems/qmake'

class Qt5_svg < Qmake
  description 'Provides classes for displaying the contents of SVG files.'
  homepage 'https://www.qt.io/'
  kde_5_15_githash = '9c3d40626ddfccc87886966a59e5cd6b1b5ce739'
  version "kde-5.15.16-#{kde_5_15_githash[0, 7]}"
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtsvg.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1193483c13758c2c5af62a09109ba6d05422f67782108ef6722437a99cc9f829',
     armv7l: '1193483c13758c2c5af62a09109ba6d05422f67782108ef6722437a99cc9f829',
     x86_64: '3c529025841d73dc1cfcb35300123ae4f028d4f222257a820e5f2693a4c69133'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'zlib' # R
end

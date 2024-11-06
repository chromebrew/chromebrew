require 'buildsystems/qmake'

class Qt5_svg < Qmake
  description 'Provides classes for displaying the contents of SVG files.'
  homepage 'https://www.qt.io/'
  kde_5_15_githash = '26fdcaff0d3d6bf6f5c847e833006577a6e8ba7d'
  version "kde-5.15.15-#{kde_5_15_githash[0, 7]}"
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtsvg.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e68ede4e09c34a681b51ed96b21a79864d523bb3c3d0267cbeb37599b64ce55a',
     armv7l: 'e68ede4e09c34a681b51ed96b21a79864d523bb3c3d0267cbeb37599b64ce55a',
     x86_64: '0a3d80df93eb60dfe82096202764d9be112622c63c59061981cad05e727f261f'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'zlib' # R
end

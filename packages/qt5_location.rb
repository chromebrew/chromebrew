require 'buildsystems/qmake'

class Qt5_location < Qmake
  description 'Qt Location and Positioning'
  homepage 'https://www.qt.io/'
  version 'kde-5.15.14-3beb9c8'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtlocation.git'
  git_hashtag '3beb9c810611337fde61d89aa981e9f177a9ede9'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e39d2752db3c2c4f4e96d9062f9d0d6fe17d3d6978c5111df581be0bca911941',
     armv7l: 'e39d2752db3c2c4f4e96d9062f9d0d6fe17d3d6978c5111df581be0bca911941',
     x86_64: '33239c1d424c16319bcc8e350ef49cd1269ce7f449acc9e76a565c05829f8007'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
  depends_on 'zlib' # R
end

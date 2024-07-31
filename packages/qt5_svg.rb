require 'buildsystems/qmake'

class Qt5_svg < Qmake
  description 'Provides classes for displaying the contents of SVG files.'
  homepage 'https://www.qt.io/'
  version 'kde-5.15.14-690128b'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtsvg.git'
  git_hashtag '690128b2b8fb6d6fbdc43b2b2633f0f1de3f0638'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3aaf26255b993c6ab543b7eacc5ba58b79cbd5680bccd918d119117fd90f7d2a',
     armv7l: '3aaf26255b993c6ab543b7eacc5ba58b79cbd5680bccd918d119117fd90f7d2a',
     x86_64: 'a89a47c8f5c18d084461941d126ba9490f05f99c58efc6e1afc66692a40b9a34'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'zlib' # R
end

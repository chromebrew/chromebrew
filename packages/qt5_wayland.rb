require 'buildsystems/qmake'

class Qt5_wayland < Qmake
  description 'Qt Wayland'
  homepage 'https://www.qt.io/'
  version 'kde-5.15.14-11e099c'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtwayland.git'
  git_hashtag '11e099c6b7fbec0e198bffaf8016676ef430cfba'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '985d78368d6f77159f9562844f9ba06436020a2fe6633fb8cd54b19d26b253e9',
     armv7l: '985d78368d6f77159f9562844f9ba06436020a2fe6633fb8cd54b19d26b253e9',
     x86_64: 'a746f8da617b182405e120ffd26f2be8f42393fb700338823dd74845afb4347c'
  })

  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libdrm' # R
  depends_on 'libglvnd' # R
  depends_on 'libx11' # R
  depends_on 'libxcomposite' # R
  depends_on 'libxext' # R
  depends_on 'libxkbcommon' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
  depends_on 'wayland' # R
  depends_on 'zlib' # R
end

require 'buildsystems/qmake'

class Qt5_wayland < Qmake
  description 'Qt Wayland'
  homepage 'https://www.qt.io/'
  kde_5_15_githash = '84870d539c396a7f202a2e14013dd13657ff5573'
  version "kde-5.15.16-#{kde_5_15_githash[0, 7]}"
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtwayland.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '20e6cf446bb38bce2e9f5631c383cd14f55bce49ed80271b02c2a74831140589',
     armv7l: '20e6cf446bb38bce2e9f5631c383cd14f55bce49ed80271b02c2a74831140589',
     x86_64: '96cc8958922995b74b45258ce8be7c6e2f78549880d00c609a6d1dbb802ab146'
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

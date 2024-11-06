require 'buildsystems/qmake'

class Qt5_wayland < Qmake
  description 'Qt Wayland'
  homepage 'https://www.qt.io/'
  kde_5_15_githash = '6b1ba1cd0e1389d13e59b94e65da8f20a89ba03f'
  version "kde-5.15.15-#{kde_5_15_githash[0, 7]}"
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtwayland.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '79f170b102db1b129c8e31ffbccbbe9e3a89edf830112a266390996fa6b552b8',
     armv7l: '79f170b102db1b129c8e31ffbccbbe9e3a89edf830112a266390996fa6b552b8',
     x86_64: 'c81fdc5af4f51642a5705a870377198d7d9f3ff05987334190deb3e8a8dd6b0e'
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

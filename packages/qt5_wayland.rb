require 'buildsystems/qmake'

class Qt5_wayland < Qmake
  description 'Qt Wayland'
  homepage 'https://www.qt.io/'
  version '5.15.11-4de268c'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtwayland.git'
  git_hashtag '4de268cbaf6ff3b633429577f06d3d746a3b202a' # from kde/5.15 branch

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_wayland/5.15.11-4de268c_armv7l/qt5_wayland-5.15.11-4de268c-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_wayland/5.15.11-4de268c_armv7l/qt5_wayland-5.15.11-4de268c-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_wayland/5.15.11-4de268c_x86_64/qt5_wayland-5.15.11-4de268c-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5afef355eb2a6fb5d97a4e06e06e2fc13f0147f97e5c841167473878788b5ab1',
     armv7l: '5afef355eb2a6fb5d97a4e06e06e2fc13f0147f97e5c841167473878788b5ab1',
     x86_64: 'e2da6a9ecb37e0a2ced50e007a6debad79179d62427882522c00045141955ce8'
  })

  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
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
  depends_on 'zlibpkg' # R
end

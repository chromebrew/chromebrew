require 'buildsystems/qmake'

class Qt5_multimedia < Qmake
  description 'Qt Multimedia'
  homepage 'https://www.qt.io/'
  version 'kde-5.15.14-53069c9'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtmultimedia.git'
  git_hashtag '53069c9c6eb52b744333812f42aed36c3db6e752'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2ac04fdf0e208e593f6639635bf212eceeeb8097a7609912a28ffc0b603964fd',
     armv7l: '2ac04fdf0e208e593f6639635bf212eceeeb8097a7609912a28ffc0b603964fd',
     x86_64: 'd2caa2b6743381f39b5d3cccca163c8b6f5fecdd9573bdc135fe3334f068e8f5'
  })

  depends_on 'alsa_lib' # R
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gstreamer' # R
  depends_on 'libglvnd' # R
  depends_on 'openal' # R
  depends_on 'pulseaudio' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
end

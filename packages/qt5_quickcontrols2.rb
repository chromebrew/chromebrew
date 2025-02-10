require 'buildsystems/qmake'

class Qt5_quickcontrols2 < Qmake
  description 'Qt Quick Controls 2'
  homepage 'https://www.qt.io/'
  kde_5_15_githash = 'd0537c14e71d0959f96592b20103033b128f9c0b'
  version "kde-5.15.15-#{kde_5_15_githash[0, 7]}"
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtquickcontrols2.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6140fe1a4f5974269261b0c133a969a96ec5adc9126feec4cf0dd5447c90b356',
     armv7l: '6140fe1a4f5974269261b0c133a969a96ec5adc9126feec4cf0dd5447c90b356',
     x86_64: 'a7938cb7fc0afe2b974f0dbff8c9e0c91e40be159d83a592abb4c1f7292e50d5'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
end

require 'buildsystems/qmake'

class Qt5_multimedia < Qmake
  description 'Qt Multimedia'
  homepage 'https://www.qt.io/'
  version '5.15.11-f587b18'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtmultimedia.git'
  git_hashtag 'f587b18db4abd68cb6d4d77fbcec1b94c38d2a51' # from kde/5.15 branch
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '682f5598df01442a3bde7ff5324bc3d43d1742e18cd24564fd4f26f51ee86a85',
     armv7l: '682f5598df01442a3bde7ff5324bc3d43d1742e18cd24564fd4f26f51ee86a85',
     x86_64: 'a2e7a9911878a22ed43e58840366b9300a69f264bb98253c34d5f8a33841dce2'
  })

  depends_on 'alsa_lib' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gstreamer' # R
  depends_on 'libglvnd' # R
  depends_on 'openal' # R
  depends_on 'pulseaudio' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
end

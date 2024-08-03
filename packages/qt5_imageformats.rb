require 'buildsystems/qmake'

class Qt5_imageformats < Qmake
  description 'Qt Image Formats'
  homepage 'https://www.qt.io/'
  version 'kde-5.15.14-4e4f5fc'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtimageformats.git'
  git_hashtag '4e4f5fc6bdac96f5281a3ebeb0fee78df7b1a498'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '21dde0735162af717a4d278a4f94d03fa2179aae6144948100bf2b575afcfacc',
     armv7l: '21dde0735162af717a4d278a4f94d03fa2179aae6144948100bf2b575afcfacc',
     x86_64: '3bdd5b73408e1022d3bba1ca9e3dc79127571d41260825d44e7e14a11fa1ef54'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'jasper' # R
  depends_on 'libglvnd' # R
  depends_on 'libmng' # R
  depends_on 'libtiff' # R
  depends_on 'libwebp' # R
  depends_on 'qt5_base' # R
end

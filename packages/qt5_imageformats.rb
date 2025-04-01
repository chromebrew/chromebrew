require 'buildsystems/qmake'

class Qt5_imageformats < Qmake
  description 'Qt Image Formats'
  homepage 'https://www.qt.io/'
  kde_5_15_githash = '7b25a0435edc2602f8999bd216c4bec711ffe09e'
  version "kde-5.15.16-#{kde_5_15_githash[0, 7]}"
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtimageformats.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c1874f0473456fa080cc25ea0493c67c7842f3d54506a4371db94190aef53263',
     armv7l: 'c1874f0473456fa080cc25ea0493c67c7842f3d54506a4371db94190aef53263',
     x86_64: 'cc1d52e534a4e59d7a5875f2ed4726f61077d5088121463b57c2acad29a517af'
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

require 'buildsystems/qmake'

class Qt5_imageformats < Qmake
  description 'Qt Image Formats'
  homepage 'https://www.qt.io/'
  kde_5_15_githash = '9f658c2093e81d1dc3333e594cc1aa4b0990e221'
  version "kde-5.15.15-#{kde_5_15_githash[0, 7]}"
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtimageformats.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e000172a4865914de761df5858288b90b3168f2c8c905547af4c883c46b33496',
     armv7l: 'e000172a4865914de761df5858288b90b3168f2c8c905547af4c883c46b33496',
     x86_64: 'd23bfbc7ec790a30aaeec21563df43c7f4071c0a3ecf783c3e4fdd76ad22a178'
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

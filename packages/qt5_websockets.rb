require 'buildsystems/qmake'

class Qt5_websockets < Qmake
  description 'Qt Websockets'
  homepage 'https://www.qt.io/'
  kde_5_15_githash = 'a0c1c335b691ad5ecaddbec17a14dcb2a129a177'
  version "kde-5.15.16-#{kde_5_15_githash[0, 7]}"
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtwebsockets.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6c4b8e6e3ca79d3d15ac6272152889fd87437c791d198cdc08779a0e7c84bfdd',
     armv7l: '6c4b8e6e3ca79d3d15ac6272152889fd87437c791d198cdc08779a0e7c84bfdd',
     x86_64: '5d6c88ca8bd71bf087c74730514d9203a74ae5f5dffdd4623520f572c4361485'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
end

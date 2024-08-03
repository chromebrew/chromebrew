require 'buildsystems/qmake'

class Qt5_websockets < Qmake
  description 'Qt Websockets'
  homepage 'https://www.qt.io/'
  version 'kde-5.15.14-dbbdc64'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtwebsockets.git'
  git_hashtag 'dbbdc64b804f7c4d0ed92198aaab49b07fa15e7f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '380f7575ea6adf126648992faf642938ff4b987357ac4cc7a7daabad0078befe',
     armv7l: '380f7575ea6adf126648992faf642938ff4b987357ac4cc7a7daabad0078befe',
     x86_64: '90dc6f7739f3fbc63a6d980f0ab1bff3e4089e4e7d7f7f514116cc1164dbac38'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
end

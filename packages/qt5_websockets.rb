require 'buildsystems/qmake'

class Qt5_websockets < Qmake
  description 'Qt Websockets'
  homepage 'https://www.qt.io/'
  version '5.15.11-d41bb9f'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtwebsockets.git'
  git_hashtag 'd41bb9f4f7ab9d5ff184ef94cf2f6ff7cf01de00' # from kde/5.15 branch
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e1b59feafd5eacece28c48eb267786dbddd6708a333afaab7144ebf552a40a8e',
     armv7l: 'e1b59feafd5eacece28c48eb267786dbddd6708a333afaab7144ebf552a40a8e',
     x86_64: 'c5b34741274657227875f94c20afb37b997687f17e11df7c5990fe64af98ae01'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
end

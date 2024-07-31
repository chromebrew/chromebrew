require 'buildsystems/qmake'

class Qt5_xmlpatterns < Qmake
  description 'Qt XML Patterns'
  homepage 'https://www.qt.io/'
  version 'kde-5.15.14-087f6f3'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtxmlpatterns.git'
  git_hashtag '087f6f35bd027f940818b1696d0aad822e034377'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a34f7d072d4c7ac45991da2fc50db2dde412c107809cc7f667beeeee4189d40d',
     armv7l: 'a34f7d072d4c7ac45991da2fc50db2dde412c107809cc7f667beeeee4189d40d',
     x86_64: '1e129317f63d27e5c34b9de016d0020600710145fcefce85df71e82bacb5e72f'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'qt5_base' # R
end

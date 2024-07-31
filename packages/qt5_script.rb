require 'buildsystems/qmake'

class Qt5_script < Qmake
  description 'Qt Script Tools'
  homepage 'https://www.qt.io/'
  version '5.15.17'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtscript.git'
  git_hashtag "v#{version}-lts"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '325ab01f8ede47f8f3dbcd3546cc26426ff3ae49b715c0256c56806d4d267ba8',
     armv7l: '325ab01f8ede47f8f3dbcd3546cc26426ff3ae49b715c0256c56806d4d267ba8',
     x86_64: '4d20958de76e3ba6390e51cee8fd7e8221fcb26d09de8d4b7914a84fdc20c298'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
end
